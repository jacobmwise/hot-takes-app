from flask_sqlalchemy import SQLAlchemy

import datetime
import hashlib
import os
import base64
import boto3
import datetime
from io import BytesIO
from mimetypes import guess_extension, guess_type
import os
from PIL import Image
import re
import random
import string

import bcrypt

db = SQLAlchemy()

#accepted extensions
EXTENSIONS = ["png", "jpg", "jpeg"]
BASE_DIR = os.getcwd()
S3_BUCKET = "hot-takes"
S3_BASE_URL = f"http://{S3_BUCKET}.s3-us-east-1.amazonaws.com"

class Asset(db.Model) :
    __tablename__ = "asset"
    id = db.Column(db.Integer, primary_key=True)
    user = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=True)
    base_url = db.Column(db.String, nullable=True)
    salt = db.Column(db.String, nullable=False)
    extension = db.Column(db.String, nullable=False)
    width = db.Column(db.Integer, nullable=False)
    height = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, nullable=False)

    def __init__(self, **kwargs):
        self.create(kwargs.get("image_data"), kwargs.get("user_id"))

    def serialize(self):
        return {
            "url" : f"{self.base_url}/{self.salt}.{self.extension}",
            "created_at" : str(self.created_at)
        }

    def create(self, image_data, user_id):
        try:
            #base64 string -> type -> extension (.png) -> extension w/o period (png)
            ext = guess_extension(guess_type(image_data)[0])[1:]
            if (ext not in EXTENSIONS) :
                raise Exception(f"Extension {ext} not supported")
            #generates random string for image name
            salt = "".join(
                random.SystemRandom().choice(
                    string.ascii_uppercase + string.digits
                )
                for _ in range (16)
            )
            #remove opening from the image data
            img_str = re.sub("^data:image/.+;base64,", "", image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIO(img_data))
            #create db object
            self.base_url = S3_BASE_URL
            self.user = user_id
            self.salt = salt
            self.extension = ext
            self.width = img.width
            self.height = img.height
            self.created_at = datetime.datetime.now()
            img_filename = f"{salt}.{ext}"
            self.upload(img, img_filename)


        except Exception as e :
            print(f"Unable to create image due to {e}")

    def upload (self, img, img_filename) :
        try :
            #save image temporarily on server
            img_temploc = f"{BASE_DIR}/{img_filename}"
            img.save(img_temploc)

            #upload to aws
            s3_client = boto3.client("s3")
            s3_client.upload_file(img_temploc, S3_BUCKET, img_filename)

            #make image publiclly accessable
            s3_resource = boto3.resource("s3")
            object_acl = s3_resource.ObjectAcl(S3_BUCKET, img_filename)
            object_acl.put(ACL="public-readable")


        except Exception as e:
            print(f"Could not upload due to {e}")


class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    profile_picture_id = db.Column(db.Integer, db.ForeignKey("asset.id"), nullable=True)
    username = db.Column(db.String, nullable=False)
    password_digest = db.Column(db.String, nullable=False)
    
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    takes = db.relationship('Take', cascade='delete')
    voted = db.relationship('Vote', cascade='delete')

    def __init__(self, **kwargs):
        self.username = kwargs.get('username', '')
        self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.renew_session()

    # Used to randomly generate session/update tokens
    def _urlsafe_base_64(self):
        return hashlib.sha1(os.urandom(64)).hexdigest()

    # Generates new tokens, and resets expiration time
    def renew_session(self):
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    def verify_password(self, password):
        return bcrypt.checkpw(password.encode("utf8"), self.password_digest)

    # Checks if session token is valid and hasn't expired
    def verify_session_token(self, session_token):
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        return update_token == self.update_token

    # Serialize functions
    def serialize(self):
        profile_picture = None
        for asset in db.session.query(Asset).order_by(self.profile_picture_id):
            profile_picture = asset.serialize().get("url")
        return {
            'id': self.id,
            'username': self.username,
            'profile_picture' : profile_picture
        }

    def serialize_with_takes(self):
        profile_picture = None
        for asset in db.session.query(Asset).order_by(self.profile_picture_id):
            profile_picture = asset.serialize().get("url")
        return {
            'id': self.id,
            'username': self.username,
            'takes': [ t.serialize() for t in self.takes ],
            'profile_picture': profile_picture
        }

    def serialize_with_voted(self):
        profile_picture = None
        for asset in db.session.query(Asset).order_by(self.profile_picture_id):
            profile_picture = asset.serialize().get("url")
        return {
            'id': self.id,
            'username': self.username,
            'voted': [ v.serialize_voted() for v in self.voted ],
            'profile_picture': profile_picture
        }

    

class Take(db.Model):
    __tablename__ = 'take'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    votes = db.relationship('Vote', cascade='delete')
    # downvotes = db.relationship('Vote', cascade='delete')

    def __init__(self, **kwargs):
        self.text = kwargs.get('text', '')
        self.user = kwargs.get('user', '')

    def serialize(self):
        return {
            'id': self.id,
            'text': self.text,
            # 'user': self.user.serialize()
        }

    def serialize_with_votes(self):
        return {
            'id': self.id,
            'text': self.text,
            # 'upvotes': [ u.serialize() for u in self.votes if u.value == True ],
            # 'downvotes': [ d.serialize() for d in self.votes if d.value == False ],
            'hot_count': sum(v.value == True for v in self.votes),
            'cold_count': sum(v.value == False for v in self.votes),
            'hot_portion': int(round((sum(v.value == True for v in self.votes) / len(self.votes)), 2) * 100) if self.votes else 0,
            'cold_portion': int(round((sum(v.value == False for v in self.votes) / len(self.votes)), 2) * 100) if self.votes else 0,
            # 'user': self.user.serialize()
        }


class Vote(db.Model):
    __tablename__ = 'vote'
    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.Boolean, nullable=False)
    take_id = db.Column(db.Integer, db.ForeignKey('take.id'), nullable=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)

    def __init__(self, **kwargs):
        self.value = kwargs.get('value', '')
        self.take = kwargs.get('take', '')

    def serialize(self):
        # take = None
        # take = db.session.query(Take).filter_by(id=self.take_id).first()

        return {
            'id': self.id,
            'value': self.value,
            # 'take': take.serialize_with_votes,
        }

    def serialize_voted(self):
        take = db.session.query(Take).filter_by(id=self.take_id).first()
        return take.serialize_with_votes()

    # def serialize_voted_take(self):
    #     take = None
    #     for asset in db.session.query(Take).order_by(self.profile_picture_id) :
    #         profile_picture = asset.serialize().get("url")

    #     return self.take.serialize_with_votes()


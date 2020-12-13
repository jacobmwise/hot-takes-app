from flask_sqlalchemy import SQLAlchemy

import datetime
import hashlib
import os

import bcrypt

db = SQLAlchemy()


class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
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

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
        }

    def serialize_with_takes(self):
        return {
            'id': self.id,
            'username': self.username,
            'takes': [ t.serialize() for t in self.takes ],
        }

    def serialize_with_voted(self):
        return {
            'id': self.id,
            'username': self.username,
            'voted': [ v.serialize() for v in self.voted ],
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
            'upvotes': [ u.serialize() for u in self.votes if u.value == True ],
            'downvotes': [ d.serialize() for d in self.votes if d.value == False ],
            'hot_count': sum(v.value == True for v in self.votes),
            'cold_count': sum(v.value == False for v in self.votes),
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

    def serialize(self):
        return {
            'id': self.id,
            'value': self.value,
        }


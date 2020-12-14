import json
import os

from db import db, User, Take, Vote, Asset
from flask import Flask, request
import users_dao

app = Flask(__name__)
db_filename = "takes.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

def success_response(data, code=200):
    return json.dumps({"success": True, "data": data}), code

def failure_response(message, code=404):
    return json.dumps({"success": False, "error": message}), code



@app.route("/")

# Authentication
def extract_token(request):
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return failure_response("Missing authorization header")

    bearer_token = auth_header.replace("Bearer ", "").strip()
    if bearer_token is None or not bearer_token:
        return failure_response("Invalid authorization header")
    
    return True, bearer_token

@app.route("/api/signup/", methods=["POST"])
def signup():
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return failure_response("Invalid username or password")

    was_created, user = users_dao.create_user(username, password)
    if not was_created:
        return failure_response("User already exists")

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
    })

@app.route("/api/login/", methods=["POST"])
def login():
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return failure_response("Invalid username or password")

    was_successful, user = users_dao.verify_credentials(username, password)

    if not was_successful:
        return failure_response("Incorrect username or password")

    
    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
    })

@app.route("/api/session/", methods=["POST"])
def update_session():
    was_successful, update_token = extract_token(request)

    if not was_successful:
        return update_token

    try:
        user = users_dao.renew_session(update_token)
    except Exception as e:
        return failure_response(f"Invalid update token: {str(e)}")
        # return json.dumps({"error": f"Invalid update token: {str(e)}"})

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
    })

@app.route("/api/secret/")
def secret_message():
    was_successful, session_token = extract_token(request)

    if not was_successful:
        return session_token

    user = users_dao.get_user_by_session_token(session_token)
    if not user or not user.verify_session_token(session_token):
        return failure_response("Invalid session token")
        
    return success_response({"message": "You have successfully implemented session tokens"})


# User Routes
@app.route("/api/users/")
def get_users():
    return success_response( [ u.serialize() for u in User.query.all() ] )

 @app.route("/api/users/", methods=["POST"])
 def create_user():
     body = json.loads(request.data)
     username = body.get("username")
     if username is None:
         return failure_response("Must provide a usernam")
     new_user = User(username=body.get("username"))
     db.session.add(new_user)
     db.session.commit()
     return success_response(new_user.serialize(), 201)

@app.route("/api/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/api/users/<int:user_id>/profile_picture/", methods=["POST"])
def upload_picture(user_id) :
    #TODO verify that the user is the one updating the profile picture
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if (image_data is None) :
        return failure_response("No base64 image")
    asset = Asset(image_data = image_data)
    db.session.add(asset)
    db.session.commit()
    return success_response(asset.serialize())


# Take Routes
@app.route("/api/users/<int:user_id>/takes/", methods=["POST"])
def create_user_take(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    body = json.loads(request.data)
    text = body.get("text")
    if text is None:
        return failure_response("Must provide a take")
    new_take = Take(text=body.get("text"), user=user)
    db.session.add(new_take)
    user.takes.append(new_take)
    db.session.commit()
    return success_response(new_take.serialize())

@app.route("/api/users/<int:user_id>/takes/")
def get_user_takes(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    return success_response( [ t.serialize_with_votes() for t in Take.query.filter_by(user_id=user_id).all() ] )

@app.route("/api/users/<int:user_id>/voted/")
def get_user_voted_takes(user_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    return success_response( user.serialize_with_voted() )

# Vote Routes
@app.route("/api/users/<int:user_id>/takes/<int:take_id>/votes/", methods=["POST"])
def vote(user_id, take_id):
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found")
    take = Take.query.filter_by(id=take_id).first()
    if take is None:
        return failure_response("Take not found")
    if user_id == take.user_id:
        return failure_response("User cannot vote on their own take")
    body = json.loads(request.data)
    value = body.get("value")
    if value is None:
        return failure_response("User must provide a vote value")
    new_vote = Vote(value=body.get("value"), take=take)
    db.session.add(new_vote)
    take.votes.append(new_vote)
    user.voted.append(new_vote)
    db.session.commit()
    return success_response(new_vote.serialize())

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)

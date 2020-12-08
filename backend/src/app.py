import json
import os

from db import db, User, Take, Vote
from flask import Flask, request

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

# User Routes
@app.route("/api/users/")
def get_users():
    return success_response( [ u.serialize() for u in User.query.all() ] )

@app.route("/api/users/", methods=["POST"])
def create_user():
    body = json.loads(request.data)
    username = body.get("username")
    email = body.get("email")
    if username is None or email is None:
        return failure_response("Must provide a username and email")
    new_user = User(username=body.get("username"), email=body.get("email"))
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


# Vote Routes
@app.route("/api/takes/<int:take_id>/votes/", methods=["POST"])
def vote(take_id):
    take = Take.query.filter_by(id=take_id).first()
    if take is None:
        return failure_response("Take not found")
    body = json.loads(request.data)
    vote = body.get("vote")
    if vote is None:
        return failure_response("User must vote")
    new_vote = Vote(vote=body.get("vote"))
    db.session.add(new_vote)
    if body.get("vote")==True:
        take.upvotes.append(new_vote)
    else:
        take.downvotes.append(new_vote)
    db.session.commit()
    return success_response(new_vote.serialize())

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)

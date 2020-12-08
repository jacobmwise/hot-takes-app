from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# take_association_table = db.Table(
#     'take_association',
#     db.Model.metadata,
#     db.Column('user_id', db.Integer, db.ForeignKey('user.id')),
#     db.Column('take_id', db.Integer, db.ForeignKey('take.id'))
# )

class User(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    takes = db.relationship('Take', cascade='delete')

    def __init__(self, **kwargs):
        self.username = kwargs.get('username', '')
        self.email = kwargs.get('email', '')

    def serialize(self):
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email,
        }

    def serialize_with_takes(self):
        return {
            'id': self.id,
            'username': self.username,
            'email': self.email,
            'takes': [ t.serialize() for t in self.takes ]
        }

    

class Take(db.Model):
    __tablename__ = 'take'
    id = db.Column(db.Integer, primary_key=True)
    text = db.Column(db.String, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=True)
    upvotes = db.relationship('Vote', cascade='delete')
    downvotes = db.relationship('Vote', cascade='delete')

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
            'upvotes': [ u.serialize() for u in self.upvotes ],
            'downvotes': [ d.serialize() for d in self.downvotes ],
            # 'user': self.user.serialize()
        }


class Vote(db.Model):
    __tablename__ = 'vote'
    id = db.Column(db.Integer, primary_key=True)
    vote = db.Column(db.Boolean, nullable=False)
    take_id = db.Column(db.Integer, db.ForeignKey('take.id'), nullable=True)

    def __init__(self, **kwargs):
        self.vote = kwargs.get('vote', '')

    def serialize(self):
        return {
            'id': self.id,
            'vote': self.vote,
        }


//
//  NetworkResponses.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

struct GenericResponse<T: Codable>: Codable{
    var success: Bool
    var data: T
}

struct ErrorResponse: Codable{
    var success: Bool
    var error: String
}

//    Sign Up
//    /api/signup/ [POST]
//    Creates a user with the given login information
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
    
//    Log In
//    /api/login/ [POST]
//    Attempts to log in with the given information
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
    
//    Update Session
//    /api/session/ [POST]
//    Updates the session
//    Request data:  update token
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
struct AuthResponse: Codable {
    var session_token: String
    var session_expiration: String
    var update_token: String
    var user_id: Int?
    var success: Bool?
    var error: String?
}
    
    
//    Get Users
//    /api/users/ [GET]
//    Returns all users
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: {[List of all users with keys “id”, “username”, and “profile_picture”]}

//Leaving this blank for right now
    
//    Create User
//    /api/users/ [POST]
//    Creates a user
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: {“id” : (Integer), “username” : (string), “profile_picture” : (string)}

//Leaving blank for now
    
//    Delete User
//    /api/users/<int: user_id>/ [POST]
//    Deletes the user with id=user_id
//    Request data:  None
//    Response data: {“id” : (Integer), “username” : (string), “profile_picture” : (string)}

//Leaving blank for now
    
//    Upload Picture
//    /api/users/<int: user_id>/profile_picture/ [POST]
//    Uploads a profile picture for the user with id=user_id
//    Request data: { “username” : (string), “password” : (string) “profile_picture” : (string)}
//    Response data: {“url” : (string), “created_at” : (string)}

struct UploadPictureResponse: Codable {
    var url: String
    var created_at: String
}
    
//    Create Take
//    /api/users/<int: user_id>/takes/ [POST]
//    Creates a take under the given user with id=user_id
//    Request data:  {“text” : (string)}
//    Response data: {“id” : (Integer), “text” : (string)}

struct CreateTakeResponse: Codable {
    var id: Int
    var text: String
}

//    Get User Takes
//    /api/users/<int: user_id>/takes/ [GET]
//    Gets all the takes submitted by user with id=user_id
//    Request data:  None
//    Response data: {[List of all user’s takes. “Id” : (Integer), “text” : (string), “hot_count” : (Integer), “cold_count” : (Integer), “hot_portion” : (Integer), “cold_portion” : (Integer)]}

    
//    Get User Voted Takes
//    /api/users/<int: user_id>/voted/ [GET]
//    Gets all takes voted on by user with id=user_id
//    Request data:  None
//    Response data: {“id” : (Integer), “username” : (string),
//    “voted” : [List of all takes user has voted on. “Id” : (Integer), “text” : (string), “hot_count” : (Integer), “cold_count” : (Integer), “hot_portion” : (Integer), “cold_portion” : (Integer)]
//    “profile_picture” : (string) }
//

struct UserTake: Codable{
    var id: Int
    var text: String
    var hot_count: Int
    var cold_count: Int
    var hot_portion: Int
    var cold_portion: Int
    var profile_picture: String?
}

struct GetUserTakesResponse: Codable{
    var takes: [UserTake]
}
//
//    Vote
//    /api/users/<int: user_id>/takes/<int: take_id>/votes/ [POST]
//    Assigns a vote for the take under user with id=user_id for take with id=take_id
//    Request data:  {“value” : (Boolean)}
//    Response data: {“id” : (Integer), “value” : (Boolean)}

struct VoteResponse: Codable{
    var id: Int
    var value: Bool
}

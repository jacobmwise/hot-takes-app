//
//  NetworkManager.swift
//  hotTakes
//
//  Created by Michael Crum on 12/14/20.
//

import Foundation
import Alamofire

class NetworkManager {
    private static let host = "https://hot-takes-app.herokuapp.com/api"
    
//    Sign Up
//    /api/signup/ [POST]
//    Creates a user with the given login information
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
    static func signUpUser(username: String, password: String, completion: @escaping (AuthResponse) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        let endpoint = "\(host)/signup/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<AuthResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    var res = decode.data
                    res.success = true
                    completion(res)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    let res = AuthResponse(session_token: "", session_expiration: "", update_token: "", success: false, error: err)
                    completion(res)
                }
            }
        }
    }

//    Log In
//    /api/login/ [POST]
//    Attempts to log in with the given information
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
    static func loginUser(username: String, password: String, completion: @escaping (AuthResponse) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        let endpoint = "\(host)/login/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<AuthResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    var res = decode.data
                    res.success = true
                    completion(res)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    let res = AuthResponse(session_token: "", session_expiration: "", update_token: "", success: false, error: err)
                    completion(res)
                }
            }
        }
    }
    
//    Update Session
//    /api/session/ [POST]
//    Updates the session
//    Request data:  update token
//    Response data: { “session_token” : (string), “session_expiration” : (string), “update_token” : (string)}
    
    
    static func updateSession(completion: @escaping (AuthResponse) -> Void) {
        let parameters: [String: Any] = [:]
        let endpoint = "\(host)/session/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<AuthResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                print(error.localizedDescription)
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    let res = AuthResponse(session_token: "", session_expiration: "", update_token: "", success: false, error: err)
                    completion(res)
                }
            }
        }
    }
        
    
    
//    Get Users
//    /api/users/ [GET]
//    Returns all users
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: {[List of all users with keys “id”, “username”, and “profile_picture”]}

    
    
//    Create User
//    /api/users/ [POST]
//    Creates a user
//    Request data:  { “username” : (string), “password” : (string) }
//    Response data: {“id” : (Integer), “username” : (string), “profile_picture” : (string)}

    
    
//    Delete User
//    /api/users/<int: user_id>/ [POST]
//    Deletes the user with id=user_id
//    Request data:  None
//    Response data: {“id” : (Integer), “username” : (string), “profile_picture” : (string)}

    
    
//    Upload Picture
//    /api/users/<int: user_id>/profile_picture/ [POST]
//    Uploads a profile picture for the user with id=user_id
//    Request data: { “username” : (string), “password” : (string) “profile_picture” : (string)}
//    Response data: {“url” : (string), “created_at” : (string)}

    static func uploadPicture(username: String, password: String, profile_picture: String, user_id: Int, completion: @escaping (UploadPictureResponse) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "profile_picture": profile_picture
        ]
        let endpoint = "\(host)/users/\(user_id)/profile_picture"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<UploadPictureResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    Create Take
//    /api/users/<int: user_id>/takes/ [POST]
//    Creates a take under the given user with id=user_id
//    Request data:  {“text” : (string)}
//    Response data: {“id” : (Integer), “text” : (string)}

    static func createTake(text: String, user_id: Int, completion: @escaping (CreateTakeResponse) -> Void) {
        let parameters: [String: Any] = [
            "text": text
        ]
        let endpoint = "\(host)/users/\(user_id)/takes/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<CreateTakeResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    print(err)
                    
                }
            }
        }
    }
    
//    Get User Takes
//    /api/users/<int: user_id>/takes/ [GET]
//    Gets all the takes submitted by user with id=user_id
//    Request data:  None
//    Response data: {[List of all user’s takes. “Id” : (Integer), “text” : (string), “hot_count” : (Integer), “cold_count” : (Integer), “hot_portion” : (Integer), “cold_portion” : (Integer)]}

    static func getUserTakes(user_id: Int, completion: @escaping ([Take]) -> Void) {
        let endpoint = "\(host)/users/\(user_id)/takes/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<[Take]>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    print(err)
                    
                }
            }
        }
    }
    
//    Get User Voted Takes
//    /api/users/<int: user_id>/voted/ [GET]
//    Gets all takes voted on by user with id=user_id
//    Request data:  None
//    Response data: {“id” : (Integer), “username” : (string),
//    “voted” : [List of all takes user has voted on. “Id” : (Integer), “text” : (string), “hot_count” : (Integer), “cold_count” : (Integer), “hot_portion” : (Integer), “cold_portion” : (Integer)]
//    “profile_picture” : (string) }
//
    static func getUserVoted(user_id: Int, completion: @escaping ([Take]) -> Void) {
        let endpoint = "\(host)/users/\(user_id)/voted/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<[Take]>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    print(err)
                    
                }
            }
        }
    }
//
//    Vote
//    /api/users/<int: user_id>/takes/<int: take_id>/votes/ [POST]
//    Assigns a vote for the take under user with id=user_id for take with id=take_id
//    Request data:  {“value” : (Boolean)}
//    Response data: {“id” : (Integer), “value” : (Boolean)}

    static func vote(value: Bool, user_id: Int, take_id: Int, completion: @escaping (VoteResponse) -> Void) {
        let parameters: [String: Any] = [
            "value": value
        ]
        let endpoint = "\(host)/users/\(user_id)/takes/\(take_id)/votes/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(GenericResponse<VoteResponse>.self, from: data) {
                    // Instructions: Use completion to handle response
                    let res = decode.data
                    completion(res)
                }
            case .failure(let error):
                let jsonDecoder = JSONDecoder()
                if let decode = try? jsonDecoder.decode(ErrorResponse.self, from: response.data!) {
                    // Instructions: Use completion to handle response
                    let err = decode.error
                    print(err)
                }
            }
        }
    }
    
}

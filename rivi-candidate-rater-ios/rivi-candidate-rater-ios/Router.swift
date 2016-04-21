//
//  Router.swift
//  rivi-mobile-ios
//
//  Created by Danny Au on 2/23/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//
//  URL generator for REST API calls.
//
//  Parameters with arrays/dictionaries: http://stackoverflow.com/questions/32595517/url-encode-alamofire-get-params-with-swiftyjson
//

import Alamofire
import Foundation
import SwiftyJSON

enum Router: URLRequestConvertible {
    case LogInUserCredentials(String, String)
    case LogInOffice365()
    case LogInRefreshToken(String, String)
    case LogOut()
    case GetTokens(String)
    case GetCurrentUser()
    case GetProfile(Int)
    case SearchUsers(String)
    case GetUserRatings(Int)
    case CreateUserRatings(Candidate)
    case UpdateUserRatings(Candidate)
    
    var URLRequest: NSMutableURLRequest {
        let result: (method: String, path: String, headers: [String: String]?, parameters: [String: AnyObject]?, encoding: Alamofire.ParameterEncoding) = {
            switch self {
            case .LogInUserCredentials(let userName, let password):
                return (Alamofire.Method.GET.rawValue, "/auth/identity/callback", nil, [
                    AUTH_KEY_AUTH_KEY: userName,
                    AUTH_KEY_PASSWORD: password,
                    AUTH_KEY_MOBILE_IDENTITY: AUTH_MOBILE_IDENTITY
                ], .URL)
            case .LogInRefreshToken(let authToken, let refreshToken):
                return (Alamofire.Method.POST.rawValue, "/tokens/oauth/refresh", [
                    AUTH_HEADER_AUTH: authToken,
                    AUTH_HEADER_REFRESH_TOKEN: refreshToken
                ], nil, .URL)
            case LogInOffice365():
                return (Alamofire.Method.GET.rawValue, "/auth/office365", nil, nil, .URL)
            case .LogOut():
                return (Alamofire.Method.PUT.rawValue, "/tokens/oauth/invalidate", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], nil, .URL)
            case .GetTokens(let authCode):
                return (Alamofire.Method.POST.rawValue, "/tokens/oauth/grant", nil, [
                    KEY_AUTH_CODE: authCode
                ], .URL)
            case .GetCurrentUser():
                return (Alamofire.Method.GET.rawValue, "/users/me", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], nil, .URL)
            case .GetProfile(let profileId):
                return (Alamofire.Method.GET.rawValue, "/people/\(profileId)", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], nil, .URL)
            case SearchUsers(let name):
                let fieldsJsonObject = JSON([
                    "name","id","avatar"
                ])
//                let filterJsonObject = JSON([])
                
                return (Alamofire.Method.GET.rawValue, "/search/all", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], [
                    KEY_FIELDS: fieldsJsonObject.rawString() ?? "",
                    KEY_Q: name,
//                    KEY_FILTER: filterJsonObject.rawString() ?? "",
                    KEY_LIMIT: 500,
                    KEY_OFFSET: 0,
//                    KEY_DECAY: 1
                ], .URL)
            case GetUserRatings(let id):
                return (Alamofire.Method.GET.rawValue, "/people/\(id)/ratings", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], nil, .URL)
            case CreateUserRatings(let candidate):
                return (Alamofire.Method.POST.rawValue, "/ratings/", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], [
                    KEY_RELATED_OBJECT_ID: candidate.id,
                    KEY_RELATED_OBJECT_TYPE: RELATED_OBJECT_TYPE_PERSON,
                    KEY_CATEGORY: RATING_TYPE_PRE_INTAKE,
                    KEY_SCORE: 0,
                    KEY_CONTENT: [
                        KEY_GOOD_LOOKS: candidate.goodLooks,
                        KEY_WEALTH: candidate.wealth,
                        KEY_MARRIAGE_POTENTIAL: candidate.marriagePotential,
                        KEY_SWAG: candidate.swag,
                        KEY_SIZE: candidate.size
                    ]
                ], .JSON)
            case UpdateUserRatings(let candidate):
                return (Alamofire.Method.PUT.rawValue, "/ratings/\(candidate.ratingId)", [
                    AUTH_HEADER_AUTH: Auth.authToken!
                ], [
                    KEY_CONTENT: [
                        KEY_GOOD_LOOKS: candidate.goodLooks,
                        KEY_WEALTH: candidate.wealth,
                        KEY_MARRIAGE_POTENTIAL: candidate.marriagePotential,
                        KEY_SWAG: candidate.swag,
                        KEY_SIZE: candidate.size
                    ]
                ], .JSON)
            }
        }()
        
        let URL = NSURL(string: BASE_URL)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        URLRequest.HTTPMethod = result.method
        if let headers = result.headers {
            for (key, value) in headers {
                URLRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        let encoding = result.encoding
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}

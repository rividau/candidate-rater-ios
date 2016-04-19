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
    case LogInRefreshToken(String, String)
//    case LogOut()
    case GetTokens(String)
    case GetCurrentUser()
    case GetProfile(Int)
//    case ForgetPassword(String)
//    case GetProfileTags(Int)
//    case GetAllTags()
//    case GetEmployments(Int)
//    case GetDegrees(Int)
//    case GetApplications(Bool, Int, Int)
//    case GetApplicationDossier(Int)
//    case SetApplicationStatus(Int, String, String?)
    
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
//            case .LogOut():
//                return (Alamofire.Method.PUT.rawValue, "/tokens/oauth/invalidate", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], nil, .URL)
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
//            case .ForgetPassword(let email):
//                return (Alamofire.Method.POST.rawValue, "/auth/identity/reset_password", nil, [
//                    AUTH_KEY_EMAIL: email
//                ], .URL)
//            case .GetProfileTags(let personId): // should also include results from "/people/\(personId)/tags" endpoint
//                return (Alamofire.Method.GET.rawValue, "/people/\(personId)/all_tags", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], nil, .URL)
//            case .GetAllTags():
////                let fieldsJsonObject = JSON([
////                    "category", "subcategory", "name", "id"
////                ])
////                let filterJsonObject = JSON([
////                    [
////                        "field": "category",
////                        "is": ["Technologies"]
////                    ]
////                ])
//                
////                return (Alamofire.Method.GET.rawValue, "search/tags", [
//                return (Alamofire.Method.GET.rawValue, "search/candidate/tags", [
//                    AUTH_HEADER_AUTH: Auth.authToken!,
//                ], [
////                        "fields": fieldsJsonObject.rawString() ?? "",
////                        "filter": filterJsonObject.rawString() ?? "",
//                    "q": "",
////                        "method": "autocomplete",
//                    "limit": 999,
//                    "offset": 0
//                ], .URL)
//            case .GetEmployments(let personId):
//                return (Alamofire.Method.GET.rawValue, "/people/\(personId)/employments", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], nil, .URL)
//            case .GetDegrees(let personId):
//                return (Alamofire.Method.GET.rawValue, "/people/\(personId)/degrees", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], nil, .URL)
//            case .GetApplications(let isOpen, let offset, let limit):
//                let scopeJson = JSON(isOpen ? [
//                    APPLICATIONS_KEY_WITH_OPEN_JOB: nil,
//                    APPLICATIONS_KEY_CANDIDATE_APP: nil
//                ] : [
//                    APPLICATIONS_KEY_WITH_OPEN_JOB: nil,
//                    APPLICATIONS_KEY_CANDIDATE_REJECT: nil
//                ])
//
//                return (Alamofire.Method.GET.rawValue, "/people/\(Auth.profile.id)/applications", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], [
//                    APPLICATIONS_KEY_SCOPE: scopeJson.rawString() ?? "",
//                    APPLICATIONS_KEY_OFFSET: offset,
//                    APPLICATIONS_KEY_LIMIT: limit,
//                    APPLICATIONS_KEY_ORDER_BY: "max_progress_order:desc,updated_at:desc"
//                ], .URL)
//            case .GetApplicationDossier(let appId):
//                return (Alamofire.Method.GET.rawValue, "/jobs/\(appId)/dossier", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], nil, .URL)
//            case SetApplicationStatus(let appId, let status, let reason):
//                let params = reason == nil ? [
//                    KEY_ID : appId,
//                    APPLICATION_KEY_STATUS : status
//                ] : [
//                    KEY_ID : appId,
//                    APPLICATION_KEY_STATUS : status,
//                    APPLICATION_KEY_REJECT_REASON : reason!
//                ]
//
//                return (Alamofire.Method.PUT.rawValue, "/applications/\(appId)", [
//                    AUTH_HEADER_AUTH: Auth.authToken!
//                ], (params as! [String : AnyObject]), .JSON)
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
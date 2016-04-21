//
//  Auth.swift
//  rivi-mobile-ios
//
//  Created by Danny Au on 2/22/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//
//  This class is responsible for all the REST API calls relating to authentication.
//

import Alamofire
import SwiftyJSON

class Auth {
    private static let USER_AUTH_WEB_VC_ID = "userAuthWebViewController"
    
    // email/pwd tokens
    static var authToken: String?
    static var refreshToken: String?
    
    // linkedin tokens
    static var linkedInAccessToken: String?
    
    static var profile = Profile()
    
    class func logInUserCredentials(userName: String, password: String, callback: (error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.LogInUserCredentials(userName, password)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            response.print()
            
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                guard let authCode = json[KEY_AUTH_CODE].string else {
                    callback(error: NSError(domain: "Auth.logInUserCredentials", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without auth code"]))
                    return
                }
                
                getTokens(authCode, callback: callback)
            case .Failure(let error):
                callback(error: error)
            }
        }
    }

    class func logInRefreshToken(authToken: String, refreshToken: String, callback: (error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.LogInRefreshToken(authToken, refreshToken)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    self.authToken = json[AUTH_KEY_AUTH_TOKEN].string
                    self.refreshToken = json[AUTH_KEY_REFRESH_TOKEN].string
                    
                    if self.authToken == nil || self.refreshToken == nil {
                        callback(error: NSError(domain: "Auth.logInRefreshToken", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without tokens"]))
                        return
                    }
                    
                    KeychainWrapper.setString(self.authToken!, forKey: AUTH_KEY_AUTH_TOKEN)
                    KeychainWrapper.setString(self.refreshToken!, forKey: AUTH_KEY_REFRESH_TOKEN)
                    
                    getProfile(callback)
                case .Failure(let error):
                    callback(error: error)
                }
        }
    }

    class func logInOffice365(viewController: UIViewController, callback: (error: NSError?) -> Void) -> Void {
        let request = NetworkManager.sharedInstance.defaultManager.request(Router.LogInOffice365()).print()
        if let storyboard = viewController.storyboard, urlRequest = request.request, userAuthWebVC = storyboard.instantiateViewControllerWithIdentifier(USER_AUTH_WEB_VC_ID) as? UserAuthWebViewController {
            userAuthWebVC.urlRequest = urlRequest
            userAuthWebVC.callback = { (authCode: String?) -> Void in
                if let authCode = authCode {
                    getTokens(authCode, callback: callback)
                } else {
                    callback(error: NSError(domain: "Auth.logInThirdParty", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without auth code"]))
                }
            }
            viewController.presentViewController(userAuthWebVC, animated: true, completion: nil)
        }
    }

    class func logOut(callback: (error: NSError?) -> Void) {
        NetworkManager.sharedInstance.defaultManager.request(Router.LogOut()).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(_):
                    authToken = nil
                    refreshToken = nil
                    profile = Profile()
                    
                    KeychainWrapper.removeObjectForKey(AUTH_KEY_AUTH_TOKEN)
                    KeychainWrapper.removeObjectForKey(AUTH_KEY_REFRESH_TOKEN)

                    callback(error: nil)
                case .Failure(let error):
                    callback(error: error)
                }
        }
    }
    
    private class func getTokens(authCode: String, callback: (error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.GetTokens(authCode)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            response.print()
            
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                authToken = json[AUTH_KEY_AUTH_TOKEN].string
                refreshToken = json[AUTH_KEY_REFRESH_TOKEN].string
                
                if authToken == nil || refreshToken == nil {
                    callback(error: NSError(domain: "Auth.getTokens", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without tokens"]))
                    return
                }
                
                KeychainWrapper.setString(authToken!, forKey: AUTH_KEY_AUTH_TOKEN)
                KeychainWrapper.setString(refreshToken!, forKey: AUTH_KEY_REFRESH_TOKEN)
                
                getProfile(callback)
            case .Failure(let error):
                callback(error: error)
            }
        }
    }
    
    private class func getProfile(callback: (error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.GetCurrentUser()).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    if let profile_id = json[PROFILE_KEY_PERSON_ID].int {
                        NetworkManager.sharedInstance.defaultManager.request(Router.GetProfile(profile_id)).print()
                            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                                response.print()
                                
                                switch response.result {
                                case .Success(let data):
                                    let json = JSON(data)
                                    if json[KEY_ID].int != nil {
                                        profile = Profile(json: json)
                                        callback(error: nil)
                                    } else {
                                        callback(error: NSError(domain: "Auth.getProfile", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without profile"]))
                                    }
                                case .Failure(let error):
                                    callback(error: error)
                                }
                        }
                    } else {
                        callback(error: NSError(domain: "Auth.getProfile", code: 0, userInfo: [KEY_MESSAGE : "SUCCESS without current user profile id"]))
                    }
                case .Failure(let error):
                    callback(error: error)
                }
        }
    }
}

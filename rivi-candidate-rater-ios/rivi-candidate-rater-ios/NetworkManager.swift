//
//  NetworkManager.swift
//  rivi-mobile-ios
//
//  Created by Danny Au on 2/22/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//
//  Custom Alamofire configuration to handle SSL security.
//  ref: https://github.com/Alamofire/Alamofire/issues/876
//

import Alamofire
import Foundation

class NetworkManager {
    static let sharedInstance = NetworkManager()
    
    let defaultManager: Alamofire.Manager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "api.dev": .DisableEvaluation
        ]
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
        configuration.HTTPAdditionalHeaders = [
            AUTH_HEADER_CLIENT_KEY: CLIENT_KEY
        ]
        
        return Alamofire.Manager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
}
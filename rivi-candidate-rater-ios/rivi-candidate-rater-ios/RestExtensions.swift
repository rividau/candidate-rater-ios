//
//  RestExtensions.swift
//  rivi-mobile-ios
//
//  Created by Danny Au on 2/25/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Alamofire
import Foundation

extension Request {
    public func print() -> Self {
        if DEBUG_LOG_HTTP {
            debugPrint(self)
        }
        
        return self
    }
}

extension Response {
    public func print() {
        if DEBUG_LOG_HTTP {
            debugPrint(self)
        }
    }
}

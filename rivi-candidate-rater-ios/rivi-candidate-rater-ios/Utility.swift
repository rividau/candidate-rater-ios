//
//  Utility.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    class func showAlert(viewController: UIViewController, title: String?, message: String, actions: [UIAlertAction]) -> Void {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        for action in actions {
            alertController.addAction(action)
        }
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func showAutoHideAlert(viewController: UIViewController, title: String?, message: String, durationSec: NSTimeInterval? = nil) -> Void {
        let alertController: AutohideAlertController
        if let durationSec = durationSec {
            alertController = AutohideAlertController(title: title, message: message, preferredStyle: .Alert, durationSec: durationSec)
        } else {
            alertController = AutohideAlertController(title: title, message: message, preferredStyle: .Alert)
        }
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
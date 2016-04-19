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
}
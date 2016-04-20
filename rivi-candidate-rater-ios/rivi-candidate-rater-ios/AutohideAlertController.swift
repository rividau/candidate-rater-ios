//
//  AutohideAlertController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//
//  Custom alert controller that automatically dismisses itself after a given duration.
//  Default is 1 second unless specified.
//

import UIKit

class AutohideAlertController: UIAlertController {
    internal var durationSec = 1.0
    
    convenience init(title: String?, message: String, preferredStyle: UIAlertControllerStyle, durationSec: NSTimeInterval) {
        self.init()
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        self.durationSec = durationSec
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSTimer.scheduledTimerWithTimeInterval(durationSec, target: self, selector: #selector(AutohideAlertController.autoHide), userInfo: nil, repeats: false)
    }
    
    func autoHide() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

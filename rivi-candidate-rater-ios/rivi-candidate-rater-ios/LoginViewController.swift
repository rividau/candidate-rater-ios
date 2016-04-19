//
//  LoginViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        email.delegate = self
        password.delegate = self
        
        // attempt auto login
        if let authToken = KeychainWrapper.stringForKey(AUTH_KEY_AUTH_TOKEN), refreshToken = KeychainWrapper.stringForKey(AUTH_KEY_REFRESH_TOKEN) {
            Auth.logInRefreshToken(authToken, refreshToken: refreshToken) { [weak self] (error) -> Void in
                if let strongSelf = self {
                    if error == nil {
                        strongSelf.gotoCandidateSelection()
                    } else {
                        print("LogInViewController.viewDidLoad() - autologin failed, error=\(error)")
                    }
                }
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func loginClicked(sender: AnyObject) {
        if let userEmail = email.text, userPassword = password.text {
            Auth.logInUserCredentials(userEmail, password: userPassword) { [weak self] (error) -> Void in
                if let strongSelf = self {
                    if error != nil {
                        Utility.showAlert(strongSelf, title: "Login Failure", message: "Unable to log in.  Please try again later", actions: [
                            UIAlertAction(title: "OK", style: .Default, handler: nil)
                        ])
                    } else {
                        strongSelf.gotoCandidateSelection()
                    }
                }
            }
        }
    }
    
    private func gotoCandidateSelection() {
        if let candidateSelectionVC = storyboard?.instantiateViewControllerWithIdentifier("candidateSelection") as? CandidateSelectionViewController {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = candidateSelectionVC
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        loginClicked(self)
        
        return true
    }
}


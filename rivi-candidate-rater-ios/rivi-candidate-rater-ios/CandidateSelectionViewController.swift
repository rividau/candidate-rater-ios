//
//  CandidateSelectionViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class CandidateSelectionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        firstName.delegate = self
        lastName.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rateClicked(sender: AnyObject) {
        if let candidateRateVC = storyboard?.instantiateViewControllerWithIdentifier("candidateRate") as? CandidateRateViewController, navController = navigationController {
            navController.pushViewController(candidateRateVC, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        rateClicked(self)
        
        return true
    }
}

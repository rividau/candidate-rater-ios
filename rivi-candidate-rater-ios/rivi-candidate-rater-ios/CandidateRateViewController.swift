//
//  CandidateRateViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

//import Charts
import UIKit

class CandidateRateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goodLooksValueChanged(sender: UISlider) {
        print("good looks value changed: \(sender.value)")
    }

    @IBAction func wealthValueChanged(sender: UISlider) {
        print("wealth value changed: \(sender.value)")
    }
    
    @IBAction func marriageValueChanged(sender: UISlider) {
        print("marriage potential value changed: \(sender.value)")
    }
    
    @IBAction func swagValueChanged(sender: UISlider) {
        print("swag level value changed: \(sender.value)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

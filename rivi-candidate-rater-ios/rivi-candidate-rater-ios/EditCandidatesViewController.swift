//
//  EditCandidatesViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class EditCandidatesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private var selectedCandidates = [Candidate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.editing = true
        selectedCandidates = Candidates.selectedCandidates
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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

extension EditCandidatesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCandidates.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if indexPath.row < selectedCandidates.count {
            cell.textLabel?.text = selectedCandidates[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            if indexPath.row < selectedCandidates.count {
                Candidates.removeCandidate(selectedCandidates[indexPath.row])
                selectedCandidates = Candidates.selectedCandidates
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
        }
    }
}

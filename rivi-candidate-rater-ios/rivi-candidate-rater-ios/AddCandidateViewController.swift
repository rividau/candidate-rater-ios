//
//  AddCandidateViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class AddCandidateViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var filteredCandidates = [Candidate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
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

extension AddCandidateViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCandidates.removeAll()
            tableView.reloadData()
        } else {
            Candidates.searchUsers(searchText) { [weak self] (candidates, error) in
                if let strongSelf = self {
                    if let candidates = candidates where error == nil {
                        strongSelf.filteredCandidates = candidates
                    } else {
                        print("unable to search for \(searchText): \(error)")
                        strongSelf.filteredCandidates.removeAll()
                    }
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
}

extension AddCandidateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCandidates.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return ROW_HEIGHT
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if indexPath.row < filteredCandidates.count {
            cell.textLabel?.text = filteredCandidates[indexPath.row].name
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < filteredCandidates.count {
            let selectedCandidate = filteredCandidates[indexPath.row]
            Candidates.getUserRatings(selectedCandidate) { [weak self] (candidate, error) in
                if let strongSelf = self {
                    Candidates.addCandidate(candidate)
                    Utility.showAutoHideAlert(strongSelf, title: nil, message: "Adding \(selectedCandidate.name)", durationSec: 0.25)
                    strongSelf.tableView.deselectRowAtIndexPath(indexPath, animated: true)
                }
            }
        }
    }
}

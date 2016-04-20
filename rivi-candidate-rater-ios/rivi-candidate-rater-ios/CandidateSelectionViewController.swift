//
//  CandidateSelectionViewController.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

class CandidateSelectionViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var filteredCandidates = [Profile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOutClicked(sender: AnyObject) {
        Auth.logOut { [weak self] (error) -> Void in
            if let strongSelf = self {
                if error == nil {
                    if let loginVC = strongSelf.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as? LoginViewController {
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = loginVC
                    }
                } else {
                    Utility.showAutoHideAlert(strongSelf, title: nil, message: "Unable to log out.  Please try again later.")
                }
            }
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

}

extension CandidateSelectionViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Candidates.searchUsers(searchText) { (error) in
            if error != nil {
            } else {
                print("unable to search for \(searchText): \(error)")
            }
        }
        let allCandidates = Candidates.sharedInstance.allCandidates
        filteredCandidates = allCandidates.filter({
            $0.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        tableView.reloadData()
    }
}

extension CandidateSelectionViewController: UITableViewDelegate, UITableViewDataSource {
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
            if let candidateRateVC = storyboard?.instantiateViewControllerWithIdentifier("candidateRate") as? CandidateRateViewController, navController = navigationController {
                candidateRateVC.profile = filteredCandidates[indexPath.row]
                navController.pushViewController(candidateRateVC, animated: true)
            }
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}

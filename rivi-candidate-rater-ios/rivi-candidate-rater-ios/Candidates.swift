//
//  Candidates.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/19/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Candidates {
    static var selectedCandidates = [Candidate]()

    class func searchUsers(name: String, callback: (candidates: [Candidate]?, error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.SearchUsers(name)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(let data):
                    var candidates = [Candidate]()
                    if let jsonArray = JSON(data).array {
                        for jsonCandidate in jsonArray {
                            candidates.append(Candidate(json: jsonCandidate))
                        }
                    }

                    callback(candidates: candidates, error: nil)
                case .Failure(let error):
                    callback(candidates: nil, error: error)
                }
        }
    }
    
    class func getUserRatings(candidate: Candidate, callback: (candidate: Candidate, error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.GetUserRatings(candidate.id)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(let data):
                    candidate.setRatings(JSON(data))
                    callback(candidate: candidate, error: nil)
                case .Failure(let error):
                    callback(candidate: candidate, error: error)
                }
        }
    }

    class func saveUserRatings(candidate: Candidate, callback: (error: NSError?) -> Void) -> Void {
        NetworkManager.sharedInstance.defaultManager.request(Router.SaveUserRatings(candidate)).print()
            .responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                response.print()
                
                switch response.result {
                case .Success(_):
                    if let selectedIndex = selectedCandidates.indexOf({ $0.id == candidate.id }) {
                        selectedCandidates[selectedIndex] = candidate
                    }
                    callback(error: nil)
                case .Failure(let error):
                    callback(error: error)
                }
        }
    }
    
    class func addCandidate(candidate: Candidate) {
        if selectedCandidates.indexOf({ $0.id == candidate.id }) == nil {
            selectedCandidates.append(candidate)
        }
    }
    
    class func removeCandidate(candidate: Candidate) {
        if let index = selectedCandidates.indexOf({ $0.id == candidate.id }) {
            selectedCandidates.removeAtIndex(index)
        }
    }
}

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
    var allCandidates: [Profile]!
    var selectedCandidates: [Profile]!
    
    class var sharedInstance :Candidates {
        struct Singleton {
            static let instance = Candidates()
        }
        return Singleton.instance
    }
    
    init() {
        allCandidates = [Profile]()
        selectedCandidates = [Profile]()
        
        let peter = Profile()
        peter.id = 111
        peter.name = "Peter"
        peter.goodLooks = 6
        peter.wealth = 8
        peter.marriagePotential = 4
        peter.swag = 2
        peter.size = 5
        allCandidates.append(peter)
        
        let eugene = Profile()
        eugene.id = 222
        eugene.name = "Eugene"
        eugene.goodLooks = 2
        eugene.wealth = 5
        eugene.marriagePotential = 8
        eugene.swag = 9
        eugene.size = 2
        allCandidates.append(eugene)

        let laura = Profile()
        laura.id = 333
        laura.name = "Laura"
        laura.goodLooks = 4
        laura.wealth = 7
        laura.marriagePotential = 5
        laura.swag = 8
        laura.size = 6
        allCandidates.append(laura)
        
        let majed = Profile()
        majed.id = 444
        majed.name = "Majed"
        majed.goodLooks = 4
        majed.wealth = 2
        majed.marriagePotential = 9
        majed.swag = 5
        majed.size = 7
        allCandidates.append(majed)
        
        let david = Profile()
        david.id = 555
        david.name = "David"
        david.goodLooks = 3
        david.wealth = 4
        david.marriagePotential = 7
        david.swag = 6
        david.size = 4
        allCandidates.append(david)
        
        let andy = Profile()
        andy.id = 666
        andy.name = "Andy"
        andy.goodLooks = 4
        andy.wealth = 6
        andy.marriagePotential = 4
        andy.swag = 2
        andy.size = 8
        allCandidates.append(andy)
    }
    
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
    
    func addCandidate(profile: Profile) {
        if selectedCandidates.indexOf({ $0.id == profile.id }) == nil {
            selectedCandidates.append(profile)
        }
    }
    
    func removeCandidate(profile: Profile) {
        if let index = selectedCandidates.indexOf({ $0.id == profile.id }) {
            selectedCandidates.removeAtIndex(index)
        }
    }
}

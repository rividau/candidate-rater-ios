//
//  Candidate.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/20/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import Foundation
import SwiftyJSON

class Candidate {
    var json: JSON!
    var jsonRatings: JSON?
    
    var id = 0
    var avatar = ""
    var name = ""

    var ratingId = 0
    var goodLooks = 0
    var wealth = 0
    var marriagePotential = 0
    var swag = 0
    var size = 0
    
    init(json: JSON) {
        self.json = json
        
        id = json[KEY_ID].int ?? 0
        avatar = json[KEY_AVATAR].string ?? "https://i.ytimg.com/vi/icqDxNab3Do/maxresdefault.jpg"
        name = json[KEY_NAME].string ?? ""
    }
    
    func setRatings(jsonRatings: JSON) {
        self.jsonRatings = jsonRatings

        goodLooks = jsonRatings[0][KEY_CONTENT][KEY_GOOD_LOOKS].int ?? 0
        wealth = jsonRatings[0][KEY_CONTENT][KEY_WEALTH].int ?? 0
        marriagePotential = jsonRatings[0][KEY_CONTENT][KEY_MARRIAGE_POTENTIAL].int ?? 0
        swag = jsonRatings[0][KEY_CONTENT][KEY_SWAG].int ?? 0
        size = jsonRatings[0][KEY_CONTENT][KEY_SIZE].int ?? 0
    }
}

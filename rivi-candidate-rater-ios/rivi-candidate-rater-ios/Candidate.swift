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
    
    var id = 0
    var avatar = ""
    var name = ""
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
}

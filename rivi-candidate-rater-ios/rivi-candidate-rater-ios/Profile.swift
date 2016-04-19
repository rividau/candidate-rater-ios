//
//  Profile.swift
//  rivi-mobile-ios
//
//  Created by Danny Au on 2/24/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//
//  Profile data model.
//

import Foundation
import SwiftyJSON

class Profile {
    var json: JSON?
    
    var id = 0
    var avatar = ""
    var avatarImage: UIImage?
    var prefix = ""
    var name = ""
    var firstName = ""
    var lastName = ""
    var nickName = ""
    var gender = ""
    var birthdate = ""
    var emailAddresses = [String: String]()
    var primaryPhone = ""
    var secondaryPhone = ""
    var workPhone = ""
    var street1 = ""
    var street2 = ""
    var city = ""
    var state = ""
    var zip = ""
    var salary = 0
    var bonus = 0
    var equity = ""
    var locationPreferences = [String]()
    var rightToWorkStatus = ""
    var willingToRelocate = false
    var currentCompany = ""
    var currentJobDescription = ""

    init(json: JSON? = nil) {
        guard let json = json else {
            return
        }

        self.json = json

        id = json[KEY_ID].int ?? 0
        avatar = json[].string ?? "https://i.ytimg.com/vi/icqDxNab3Do/maxresdefault.jpg"
        prefix = json[PROFILE_KEY_PREFIX].string ?? ""
        name = json[KEY_NAME].string ?? ""
        firstName = json[PROFILE_KEY_FIRST_NAME].string ?? ""
        lastName = json[PROFILE_KEY_LAST_NAME].string ?? ""
        nickName = json[PROFILE_KEY_NICKNAME].string ?? ""
        gender = json[PROFILE_KEY_GENDER].string ?? ""
        birthdate = json[PROFILE_KEY_BIRTHDATE].string ?? ""
        if let emails = json[PROFILE_KEY_EMAIL_ADDRESSES].arrayObject {
            for email in emails {
                if let category = email[KEY_CATEGORY] as? String, emailAddress = email[PROFILE_KEY_EMAIL_ADDRESS] as? String {
                    emailAddresses[category] = emailAddress
                }
            }
        }
        primaryPhone = json[PROFILE_KEY_PRIMARY_PHONE].string ?? ""
        secondaryPhone = json[PROFILE_KEY_SECONDARY_PHONE].string ?? ""
        workPhone = json[PROFILE_KEY_WORK_PHONE].string ?? ""
        street1 = json[PROFILE_KEY_CURRENT_LOCATION][PROFILE_KEY_STREET_ADDRESS_1].string ?? ""
        street2 = json[PROFILE_KEY_CURRENT_LOCATION][PROFILE_KEY_STREET_ADDRESS_2].string ?? ""
        city = json[PROFILE_KEY_CURRENT_LOCATION][PROFILE_KEY_CITY].string ?? ""
        state = json[PROFILE_KEY_CURRENT_LOCATION][PROFILE_KEY_STATE].string ?? ""
        zip = json[PROFILE_KEY_CURRENT_LOCATION][PROFILE_KEY_ZIP].string ?? ""
        if let locations = json[PROFILE_KEY_LOCATION_PREFERENCES].arrayObject as? [String] {
            locationPreferences = locations
        }
        salary = json[PROFILE_KEY_SALARY].int ?? 0
        bonus = json[PROFILE_KEY_BONUS].int ?? 0
        equity = json[PROFILE_KEY_EQUITY].string ?? ""
        rightToWorkStatus = json[PROFILE_KEY_RIGHT_TO_WORK_STATUS].string ?? ""
        willingToRelocate = json[PROFILE_KEY_WILLING_RELOCATE].bool ?? false
        currentCompany = json[PROFILE_KEY_CURRENT_EMPLOYMENT][KEY_COMPANY_NAME].string ?? ""
        currentJobDescription = json[PROFILE_KEY_CURRENT_EMPLOYMENT][PROFILE_KEY_DESCRIPTION].string ?? ""
        
        print("")
    }
}

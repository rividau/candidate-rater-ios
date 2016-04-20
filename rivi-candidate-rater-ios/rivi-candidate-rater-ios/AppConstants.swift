//
//  AppConstants.swift
//  rivi-candidate-rater-ios
//
//  Created by Danny Au on 4/18/16.
//  Copyright © 2016 Riviera Partners. All rights reserved.
//

import UIKit

public let DEBUG_LOG_HTTP = true

// delve
//public let BASE_URL = "http://api.dev:3000"
//public let CLIENT_KEY = "6a84134a-219e-4d93-8cf0-240d20eba870"

// sutro
public let BASE_URL = "http://api.dev:3000"
////public let BASE_URL = "https://localhost:9292"
public let CLIENT_KEY = "df246603-86d1-4ad3-9779-5d4ecdaf8569"

let AUTH_HEADER_CLIENT_KEY              = "Client-Key"
let AUTH_HEADER_AUTH                    = "Authorization"
let AUTH_HEADER_REFRESH_TOKEN           = "Refresh-Token"
let AUTH_KEY_AUTH_KEY                   = "auth_key"
let AUTH_KEY_PASSWORD                   = "password"
let AUTH_KEY_MOBILE_IDENTITY            = "mobile_identity"
let AUTH_MOBILE_IDENTITY                = "true"
let AUTH_KEY_AUTH_TOKEN                 = "auth_token"
let AUTH_KEY_REFRESH_TOKEN              = "refresh_token"
let KEY_AUTH_CODE                       = "authorization_code"
let KEY_MESSAGE                         = "message"
let KEY_ID                              = "id"
let KEY_NAME                            = "name"
let KEY_COMPANY_NAME                    = "company_name"
let KEY_CATEGORY                        = "category"
let KEY_FIELDS                          = "fields"
let KEY_Q                               = "q"
let KEY_FILTER                          = "filter"
let KEY_LIMIT                           = "limit"
let KEY_OFFSET                          = "offset"
let KEY_DECAY                           = "decay"
let KEY_AVATAR                          = "avatar"

let QUERY_ERROR                         = "error"

// MARK: Profile

let PROFILE_KEY_PREFIX                  = "prefix"
let PROFILE_KEY_FIRST_NAME              = "first_name"
let PROFILE_KEY_LAST_NAME               = "last_name"
let PROFILE_KEY_NICKNAME                = "nickname"
let PROFILE_KEY_EMAIL_ADDRESSES         = "email_addresses"
let PROFILE_KEY_EMAIL_ADDRESS           = "email_address"
let PROFILE_KEY_PERSON_AVATAR           = "person_avatar"
let PROFILE_KEY_PERSON_ID               = "person_id"
let PROFILE_KEY_LOCATION_PREFERENCES    = "location_preferences"
let PROFILE_KEY_PRIMARY                 = "Primary"
let PROFILE_KEY_SECONDARY               = "Secondary"
let PROFILE_KEY_WORK                    = "Work"
let PROFILE_KEY_GENDER                  = "gender"
let PROFILE_KEY_BIRTHDATE               = "birthdate"
let PROFILE_KEY_PRIMARY_PHONE           = "primary_phone"
let PROFILE_KEY_SECONDARY_PHONE         = "secondary_phone"
let PROFILE_KEY_WORK_PHONE              = "work_phone"
let PROFILE_KEY_CURRENT_LOCATION        = "current_location"
let PROFILE_KEY_STREET_ADDRESS_1        = "street_address_1"
let PROFILE_KEY_STREET_ADDRESS_2        = "street_address_2"
let PROFILE_KEY_CITY                    = "city"
let PROFILE_KEY_STATE                   = "state"
let PROFILE_KEY_ZIP                     = "zip_code"
let PROFILE_KEY_SALARY                  = "salary_expectation"
let PROFILE_KEY_BONUS                   = "bonus_expectation"
let PROFILE_KEY_EQUITY                  = "equity_expectation"
let PROFILE_KEY_RIGHT_TO_WORK_STATUS    = "right_to_work_status"
let PROFILE_KEY_WILLING_RELOCATE        = "willing_to_relocate"
let PROFILE_KEY_CURRENT_EMPLOYMENT      = "current_employment"
let PROFILE_KEY_DESCRIPTION             = "description"
let PROFILE_GENDER_MALE                 = "M"
let PROFILE_GENDER_FEMALE               = "F"
let PROFILE_TRUE                        = "true"
let PROFILE_FALSE                       = "false"

let ROW_HEIGHT = CGFloat(50)
let PARAMETERS = ["Good Looks", "Wealth O'Meter", "Marriage Potential", "Swag Level", "Shoe/Bra Size"]

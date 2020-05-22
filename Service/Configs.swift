//
//  Configs.swift
//  FastShare
//
//  Created by Fullname on 1/18/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import Foundation

struct Production {
    
    
//    static let BASE_URL: String = "http://simthanhdat.vn/api/"
      static let BASE_URL: String = "http://adong-api-dev.zamio.net/api/"
    static let DOMAIN: String = "http://adong-api-dev.zamio.net/api/"
    static var  ACCESS_TOKEN: String = ""
    static var  USER_ROLE: String = ""
  
}

struct OneSignalNoTification {
    static var MoveFromNotification = false
    static var CartId = 0
    static var EventName = ""
    static var ReservationId = 0
    static var SimId = 0
}

struct OneSignalNoTificationName {
     static var  AffiliateCartOrdered = "affiliateCartOrdered"
     static var WebOrdered = "webOrdered"
     static var AgencyResponed = "agencyResponed"
     static var AffiliateCartDone = "affiliateCartDone"
     static var AffiliateApplied = "affiliateApplied"
     static var AgencyApplied = "agencyApplied"
     static var AgencyCancelled = "agencyCancelled"
      static var AffiliateCartCancelled = "affiliateCartCancelled"
}

enum NetworkErrorType {
    case API_ERROR
    case HTTP_ERROR
}

struct Parameter {
    // headers
    static let Accept = "Accept"
    static let ApplicationJson = "application/json"
    static let AccessTokenType = "access-token"
    static let ContentType = "Content-Type"
    static let FormUrlEncoded = "application/x-www-form-urlencoded"
    static let MultiPartFormData = "multipart/form-data"
}

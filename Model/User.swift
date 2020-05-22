//
//  User.swift
//  FastShare
//
//  Created by Fullname on 1/18/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, Mappable, NSCoding {
    
    
    
    var accessToken: String?
    var fullName: String?
    var avatarExtId: String?
    var avatarUrl:String?
    var message:String?
    var userId:Int?
    
    override init() {}
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        accessToken <- map["accessToken"]
        fullName <- map["fullName"]
        avatarExtId <- map["avatarExtId"]
        avatarUrl <- map["avatarUrl"]
        message <- map["message"]
        userId <- map["userId"]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(fullName, forKey: "fullName")
        coder.encode(avatarExtId, forKey: "avatarExtId")
        coder.encode(avatarUrl, forKey: "avatarUrl")
        coder.encode(message, forKey: "message")
        coder.encode(userId, forKey: "userId")
    }
    
    required init(coder decoder: NSCoder) {
        self.accessToken = decoder.decodeObject(forKey: "accessToken") as? String ?? ""
        self.fullName = decoder.decodeObject(forKey: "fullName") as? String ?? ""
        self.avatarExtId = decoder.decodeObject(forKey: "avatarExtId") as? String ?? ""
        self.avatarUrl = decoder.decodeObject(forKey: "avatarUrl") as? String ?? ""
        self.message = decoder.decodeObject(forKey: "message") as? String ?? ""
        self.userId = decoder.decodeObject(forKey: "userId") as? Int ?? 0
    }
    
}


class Roles:Mappable {
    
    var roles:[String]?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        roles <- map["roles"]
    }
}

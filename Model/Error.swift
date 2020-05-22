//
//  Error.swift
//  ADongPr
//
//  Created by Cuongvh on 5/21/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit
import ObjectMapper

@objcMembers class Error: Mappable {
    var field : String?
    var message : String?
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        field <- map["field"]
        message <- map["message"]
    }
    
}

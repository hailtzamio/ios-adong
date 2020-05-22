

import Foundation
import ObjectMapper

@objcMembers class Permission : Mappable {
	var id : Int?
	var authorityId : Int?
	var appEntityId : Int?
	var appEntityCode = ""
	var action : String?

    required convenience init?(map: Map) {
        self.init()
         mapping(map: map)
     }

    func mapping(map: Map) {
		id <- map["id"]
		authorityId <- map["authorityId"]
		appEntityId <- map["appEntityId"]
		appEntityCode <- map["appEntityCode"]
		action <- map["action"]
	}

}

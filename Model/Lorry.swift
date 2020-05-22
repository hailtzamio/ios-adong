import Foundation
import ObjectMapper

@objcMembers class Lorry : Mappable {
	var id : Int?
	var brand : String?
	var model : String?
	var plateNumber : String?
	var capacity : String?
	var latitude : Int?
	var longitude : Int?
	var address : String?
	var status : String?
	var createdTime : String?
	var updatedTime : String?
	var driverId : String?
	var driverFullName : String?
	var tripId : String?
	var tripName : String?
	var createdById : Int?
	var createdByFullName : String?
	var updatedById : Int?
	var updatedByFullName : String?

    required convenience init?(map: Map) {
          self.init()
           mapping(map: map)
       }

    func mapping(map: Map) {

		id <- map["id"]
		brand <- map["brand"]
		model <- map["model"]
		plateNumber <- map["plateNumber"]
		capacity <- map["capacity"]
		latitude <- map["latitude"]
		longitude <- map["longitude"]
		address <- map["address"]
		status <- map["status"]
		createdTime <- map["createdTime"]
		updatedTime <- map["updatedTime"]
		driverId <- map["driverId"]
		driverFullName <- map["driverFullName"]
		tripId <- map["tripId"]
		tripName <- map["tripName"]
		createdById <- map["createdById"]
		createdByFullName <- map["createdByFullName"]
		updatedById <- map["updatedById"]
		updatedByFullName <- map["updatedByFullName"]
	}

}

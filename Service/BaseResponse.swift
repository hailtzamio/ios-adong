//
//  BaseResponse.swift
//  FastShare
//
//  Created by Fullname on 1/18/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Mappable {
    var status: Int?
    var code: Int?
    var message: String?
    var data: T?
    var validationErrors: [Error]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["status_code"]
        message <- map["message"]
        data <- map["data"]
          validationErrors <- map["validationErrors"]
    }
    
    func isSuccessCode() -> Bool? {
        return code == 200
    }
}

class BaseResponseList<T: Mappable>: Mappable {
    var status: Int?
    var code: Int?
    var message: String?
    var data: [T]?
    var pagination:Pagination?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        code <- map["status_code"]
        message <- map["message"]
        data <- map["data"]
        pagination <- map["pagination"]
    }
    
    func isSuccessCode() -> Bool? {
        return code == 200
    }
    
    

}

class Pagination:Mappable {
    
    var currentPage: Int?
    var pageSize: Int?
    var totalRecords: Int?
    var totalPages: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        currentPage <- map["currentPage"]
        pageSize <- map["pageSize"]
        totalRecords <- map["totalRecords"]
        totalPages <- map["totalPages"]
    }
}


class BaseResponseError {
    var mErrorType: NetworkErrorType!
    var mErrorCode: Int!
    var mErrorMessage: String!
    
    init(_ errorType: NetworkErrorType,_ errorCode: Int,_ errorMessage: String) {
        mErrorType = errorType
        mErrorCode = errorCode
        mErrorMessage = errorMessage
    }
}

class ServerResponse: Mappable{
    
    var status : Int?
    var message : String?
    var data : AnyObject?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

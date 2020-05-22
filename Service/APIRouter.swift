//
//  APIRouter.swift
//  FastShare
//
//  Created by Fullname on 1/18/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    // =========== Begin define api ===========
    case login(username: String, password: String)
    case changePassword(newPass: String, confirmNewPass: String)
    case loginWithFacebook(facebook_id:String)
    case register(fullname:String, password:String, email:String, phone:String)
    case updateProfile(fullname:String, emai:String,avatar:String)
    case searchSim(telcoId:String, categoryId:String,pattern:String, priceFrom:String,priceTo:String, page:Int,number:String,birthYear:String, notContain4:Bool,notContain7:Bool,sort:String)
    
    case getPermission
    
    case getLorry
    case getLorryById(id:Int)
    case renoveLorry(id:Int)
    case createLorry(data:Lorry)
    case updateLorry(data:Lorry)
    
    case holdSim(simId:String)
    case myCart(page:Int)
    case myProfile(d:String)
    case addNewCart(simId:CLong, customerName:String, customerPhone:String, customerAddress:String)
    case getCartById(carId:CLong)
    case getReservationAgency(id:Int)
    case getSimOrderAgency(status:String)
    case approveOrderByAgency(orderId:CLong)
    case cancelOrderByAgency(orderId:CLong)
    
    case payable(page:String, size:String, fromDate:String, toDate:String)
    
    // =========== End define api ===========
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login, .changePassword,.loginWithFacebook, .updateProfile, .register, .holdSim, .addNewCart, .approveOrderByAgency, .createLorry:
            return .post
        case .searchSim, .getLorryById, .getLorry, .myCart, .myProfile,.getCartById, .getSimOrderAgency, .cancelOrderByAgency, .payable, .getReservationAgency, .getPermission:
            return .get
        case .updateLorry :
            return .put
        case .renoveLorry :
            return .delete
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "login"
        case .getPermission:
            return "myPermissions"
        case .loginWithFacebook:
            return "user/login-by-google"
        case .changePassword:
            return "change-password"
        case .register:
            return "register"
        case .searchSim:
            return "search"
        case .updateProfile:
            return "update-profile"
        case .updateLorry(let data):
            return "lorry/\(String(describing: data.id))"
        case .holdSim:
            return "affiliate/add-to-cart"
        case .getLorryById(let id):
            return "lorry/\(id)"
        case .renoveLorry(let id):
            return "lorry/\(id)"
        case .getLorry:
            return "lorry"
        case .myCart:
            return "affiliate/carts"
        case .myProfile:
            return "me"
        case .createLorry:
            return "lorry"
        case .addNewCart:
            return "affiliate/new-cart"
        case .getCartById:
            return "affiliate/cart"
        case .getSimOrderAgency:
            
            return "agency/orders"
        case .approveOrderByAgency:
            return "agency/approve-order"
        case .cancelOrderByAgency:
            return "agency/cancel-order"
        case .payable :
            return "affiliate/payable"
        case .getReservationAgency:
            return "reservation"
        }
    }
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers = ["Content-Type": "application/json"]
        switch self {
        case .login:
            //            headers["Authorization"] = "Basic YXBwMToxMjM0NTY="
            break
        case .loginWithFacebook:
            break
            
        case .register:
            
            break
        case .changePassword, .searchSim, .updateProfile, .updateLorry, .holdSim, .renoveLorry, .getLorry, .myCart, .myProfile, .createLorry, .addNewCart, .getCartById, .getSimOrderAgency, .approveOrderByAgency, .cancelOrderByAgency, .payable,.getReservationAgency, .getPermission, .getLorryById:
            headers["Authorization"] = getAuthorizationHeader()
            break
        }
        
        return headers;
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let username, let password):
            return [
                "username": username,
                "password": password
            ]
            
        case .loginWithFacebook(let facebook_id):
            return ["google_id":facebook_id]
        case .changePassword(let currentPassword, let newPassword):
            return[
                "currentPassword": currentPassword,
                "newPassword": newPassword
            ]
            
        case .register(let fullName,let password,let email,let phone):
            return [
                
                "fullName": fullName,
                "password": password,
                "email": email,
                "phone": phone
            ]
            
        case .searchSim(let telcoId, let categoryId, let pattern, let priceFrom, let priceTo, let page,let number, let birthYear, let notContain4,let notContain7, let sort):
            return [
                "pattern":pattern,
                "telcoId": telcoId,
                "categoryId": categoryId,
                "page": page,
                "priceFrom": priceFrom,
                "priceTo":priceTo,
                "notContain4":notContain4,
                "notContain7":notContain7,
                "number":number,
                "birthYear":birthYear,
                "sort":sort,
                "status":0
            ]
            
        case .updateProfile(let fullName,let email,let avatar):
            return [
                "fullName": fullName,
                "password": email,
                "email": avatar,
                "phone": "0912999999"
            ]
            
        case .getLorryById:
            return [:]
            
        case .renoveLorry :
            return [:]
        
        case .holdSim(let simId):
            return [
                "simId":simId
            ]
        case .getPermission :
            return [:]
        case .getLorry:
            return [:]
            
        case .myCart(let page):
            return [
                "size":100,
                "page": page,
            ]
            
        case .myProfile(let a):
            return [:]
            
        case .createLorry(let data):
            return [
                "brand":data.brand ?? "",
                "model": data.model,
                "plateNumber":data.plateNumber,
                "capacity":data.capacity,
            ]
        case .updateLorry(let data):
            return [
                "brand":data.brand,
                "model": data.model,
                "plateNumber":data.plateNumber,
                "capacity":data.capacity,
            ]
            
        case .addNewCart(let simId, let customerName, let customerPhone, let customerAddress):
            return [
                "simId": simId,
                "customerName": customerName,
                "customerPhone": customerPhone,
                "customerAddress": customerAddress
            ]
            
        case .getCartById(let carId):
            return [
                "id": carId
            ]
            
        case .getSimOrderAgency(let status):
            return [
                "status":status
            ]
            
        case .approveOrderByAgency(let orderId):
            return [
                "orderId":orderId
            ]
            
        case .cancelOrderByAgency(let orderId):
            return [
                "orderId":orderId
            ]
            
        case .payable(let page, let size, let fromDate, let toDate):
            return [
                "size":size,
                "page": page,
                "fromDate":fromDate,
                "toDate" : toDate
            ]
            
        case .getReservationAgency(let id) :
            return [
                "id":id
            ]
        }
        
    }
    
    // MARK: - URL request
    func asURLRequest() throws -> URLRequest {
        
        
        
        let url = try Production.BASE_URL.asURL()
        
        // setting path
        var urlRequest: URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.timeoutInterval = 10
        
        // setting method
        urlRequest.httpMethod = method.rawValue
        
        // setting header
        for (key, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                print("Encoding fail")
            }
        }
        
        return urlRequest
    }
    
    private func getAuthorizationHeader() -> String? {
        return "Bearer " + Production.ACCESS_TOKEN
    }
}

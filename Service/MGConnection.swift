//
//  MGConnection.swift
//  FastShare
//
//  Created by Fullname on 1/18/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper



class MGConnection {
    
    static func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func requestDataListWithPage<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: BaseResponseList<T>?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            print("check internet!")
            let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, 40, "Internet BaseResponseError!")
            completion(nil, err)
            return
        }
        
        
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<BaseResponseList<T>>) in
            print(response.request)
            print(response.request?.httpBody)
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.status == 200) {
                        completion((response.result.value), nil)
                    } else {
                        let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.API_ERROR, (response.result.value?.code)!, (response.result.value?.message)!)
                        completion(nil, err)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is BaseResponseError!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
    
    static func requestDataList<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: [T]?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            print("check internet!")
            let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, 40, "Internet BaseResponseError!")
            completion(nil, err)
            return
        }
        
        
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<BaseResponseList<T>>) in
            print(response.request)
            print(response.request?.httpBody)
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.status == 1) {
                        completion((response.result.value?.data)!, nil)
                    } else {
                        completion(nil, nil)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is BaseResponseError!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
    
    static func request<T: Mappable>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        if !isConnectedToInternet() {
            let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, 40, "Internet BaseResponseError!")
            completion(nil, err)
            return
        }
        
        
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<BaseResponse<T>>) in
            print(response.request)
            print(response.request?.httpBody)
            
            
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.status == 1) {
                        completion((response.result.value?.data)!, nil)
                    } else {
                        let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.API_ERROR, (response.result.value?.code)!, (response.result.value?.message)!)
                        completion(nil, err)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is BaseResponseError!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
    
    func test() {
    
    }
    
    static func requestRemove<T: ResponseDefault>(_ apiRouter: APIRouter,_ returnType: T.Type, completion: @escaping (_ result: T?, _ error: BaseResponseError?) -> Void) {
        
        Alamofire.request(apiRouter).responseObject{(response: DataResponse<T>) in
            
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 {
                    if (response.result.value?.status == 1) {
                        completion(response.result.value!, nil)
                    } else {
                        completion(nil, nil)
                    }
                } else {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, (response.response?.statusCode)!, "Request is BaseResponseError!")
                    completion(nil, err)
                }
                break
                
            case .failure(let error):
                if error is AFError {
                    let err: BaseResponseError = BaseResponseError.init(NetworkErrorType.HTTP_ERROR, error._code, "Request is error!")
                    completion(nil, err)
                }
                
                break
            }
        }
    }
}

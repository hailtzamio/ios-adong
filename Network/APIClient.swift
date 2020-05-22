//
//  APIClient.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire
import Foundation

class APIClient {
    @discardableResult
    private static func performRequest<T:Decodable>(route:ApiRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Swift.Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){ (response: DataResponse<T, AFError>) in
                            completion(response.result)
                            print(response.response?.statusCode)
                            print(response.result)
        }
    }
    
    static func login(email: String, password: String, completion:@escaping (Swift.Result<Article, AFError>)->Void) {
        performRequest(route: ApiRouter.login(email: email, password: password), completion: completion)
    }
    
    static func getArticles(completion:@escaping (Swift.Result<Article, AFError>)->Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.articleDateFormatter)
        performRequest(route: ApiRouter.articles, decoder: jsonDecoder, completion: completion)
    }
}


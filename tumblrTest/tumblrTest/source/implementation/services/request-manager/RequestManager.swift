//
//  RequestManager.swift
//  tumblrTest
//
//  Created by Vlad Demchenko on 3/25/19.
//  Copyright © 2019 Vlad Demchenko. All rights reserved.
//

import Foundation

import Alamofire


public enum ResultRequest {
    case success(Data)
    case error(Error?)
}

public typealias JSON = [String : Any]
public typealias Completion = (ResultRequest) -> ()

class RequestManager {
    
    class func request(
        url: String,
        parameters: JSON?,
        requestMethod: HTTPMethod,
        _ encoding: URLEncoding = URLEncoding.default,
        completion: @escaping Completion
        ){
        if NetworkReachabilityManager()?.isReachable == false {
            let _ = completion(.error(NSError.noInternetConnection))
        }
        
        
        Alamofire.request(
            url,
            method: requestMethod,
            parameters: parameters,
            encoding: encoding
            ).responseData { (response) in
                guard let statusCode = response.response?.statusCode else {
                    completion(.error(NSError.serverError))
                    return
                }
                if statusCode == 200 {
                    if let data = response.data {
                        completion(.success(data))
                    }
                } else {
                    completion(.error(response.error))
                }
        }
        
    }
    
}

//
//  RequestPath.swift
//  tumblrTest
//
//  Created by Vlad Demchenko on 3/25/19.
//  Copyright © 2019 Vlad Demchenko. All rights reserved.
//

import Foundation

public enum BaseURL {
    static let domain = "https://api.tumblr.com"
}

public class BasePath {
    class func url() -> String {
        return BaseURL.domain
    }
}

public enum Path {
    static let endpoint: String = "/v2"
    
    enum Request: String {
        case tagged = "/tagged"
        
        func url() -> String {
            return BasePath.url() + Path.endpoint + self.rawValue
        }
    }
}

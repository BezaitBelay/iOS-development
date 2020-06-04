//
//  EndPoint.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURl: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponent: URLComponents {
        var component = URLComponents(string: baseURl)
        component?.path = path
        component?.queryItems = queryItems
        
        if let component = component {
            return component
        }
        return URLComponents()
    }
    
    var request: URLRequest {
        if let url = urlComponent.url {
            return URLRequest(url: url)
        }
        return URLRequest(url: URL(fileURLWithPath: ""))
    }
}

enum EntityEndpoint: Endpoint {
    case contact(es: String)
    
    var baseURl: String {
        return "https://apiuat.dynamosoftware.com"
    }
    
    var path: String {
        switch self {
        case .contact(let es):
            return "/api/v2.1/entity/\(es)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

// 
//  SessionTokenRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 19.12.18 г..
//

import UIKit

public class SessionTokenRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .post
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.baseUrl
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .inApp
    }
    
    override public var path: String {
        return "\(ApiComponents.version)/token"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .none
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        let dict: [String: String] = ["Content-Type": "application/json;"]
        return dict
    }
}

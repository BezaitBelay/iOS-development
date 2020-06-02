// 
//  AccessTokenRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 12.06.19.
//

import UIKit

public class AccessTokenRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .post
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.newClUrl
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .login
    }
    
    override public var path: String {
        return "/connect/token"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .none
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        let dict: [String: String] = ["Content-Type": "application/x-www-form-urlencoded;",
                                      "accept": "application/json"]
        return dict
    }
}

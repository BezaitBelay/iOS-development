// 
//  LoginRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 18.12.18 г..
//

import UIKit

public class LoginRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .post
    }
    
    override public var baseUrl: BaseURL {
        return ""
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .login
    }
    
    override public var path: String {
        return "/iDynamoServiceSSO/account/login"
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

// 
//  SSOLoginRequest.swift
//  Alamofire
//
//  Created by hackaton on 21.12.18.
//

import UIKit

public class SSOLoginRequest: BaseAPIRequest {
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
        return "/iDynamoServiceSSO/account/loginWithToken"
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

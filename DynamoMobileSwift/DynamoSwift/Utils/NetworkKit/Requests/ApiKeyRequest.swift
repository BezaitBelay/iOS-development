// 
//  ApiKeyRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 12.06.19.
//

import UIKit

public class ApiKeyRequest: BaseAPIRequest {
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
        return "/api/getapikey"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .requiredForLogin
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        var dict: [String: String] = ["Content-Type": "application/x-www-form-urlencoded;",
                                      "accept": "application/json"]
        if let token = APIManager.shared.accessToken,
            authorizationRequirement != .none {
            dict["Authorization"] = "Bearer \(token)"
        }
        return dict
    }
}

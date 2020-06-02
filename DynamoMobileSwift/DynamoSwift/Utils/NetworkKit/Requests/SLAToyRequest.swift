//
//  SLAToyRequest.swift
//  DynamoSwift
//
//  Created by Aleksandar Geyman on 28.10.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import UIKit

public class SLAToyRequest: BaseAPIRequest {
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
        return "/api/gettoy"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .requiredForLogin
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        var dict: [String: String] = ["Content-Type": "application/json;"]
        if let token = APIManager.shared.accessToken,
            authorizationRequirement != .none {
            dict["Authorization"] = "Bearer \(token)"
        }
        return dict
    }
}

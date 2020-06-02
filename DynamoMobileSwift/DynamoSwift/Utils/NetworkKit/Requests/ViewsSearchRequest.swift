//
//  ViewsSearchRequest.swift
//  DynamoSwift
//
//  Created by Aleksandar Geyman on 25.10.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import UIKit

public class ViewsSearchRequest: BaseAPIRequest {
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
        return "\(ApiComponents.version)/view"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .required
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        var dict: [String: String] = ["Content-Type": "application/json;"]
        if let token = APIManager.shared.authToken,
            authorizationRequirement != .none {
            dict["Authorization"] = "Bearer \(token)"
        }
        return dict
    }
}

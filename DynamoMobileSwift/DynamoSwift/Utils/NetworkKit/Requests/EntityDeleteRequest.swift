//
//  EntityDeleteRequest.swift
//  NetworkKit
//
//  Created by Diana Mihaylova on 2.04.19.
//

import Foundation

public class EntityDeleteRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .delete
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.baseUrl
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .inApp
    }
    
    override public var path: String {
        return "\(ApiComponents.version)/entity"
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

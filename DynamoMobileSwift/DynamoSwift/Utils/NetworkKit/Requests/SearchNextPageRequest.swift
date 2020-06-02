// 
//  SearchNextPageRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 8.02.19.
//

import UIKit

public class SearchNextPageRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .get
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.baseUrl
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .inApp
    }
    
    override public var path: String {
        return "\(ApiComponents.version)/search"
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

// 
//  ViewsRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 20.03.19.
//

import UIKit

public class ViewsRequest: BaseAPIRequest {
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

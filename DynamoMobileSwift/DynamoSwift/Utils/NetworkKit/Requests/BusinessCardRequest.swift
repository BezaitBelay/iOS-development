// 
//  BusinessCardRequest.swift
//  Alamofire
//
//  Created by Rumyana Atanasova on 3.06.19.
//

import UIKit

public class BusinessCardRequest: BaseAPIRequest {
    override public var httpMethod: HTTPMethod {
        return .post
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.businessCardUrl
    }
    
    override public var customUrlType: CustomBaseUrlType {
        return .none
    }
    
    override public var path: String {
        return "/BCRService/BCR_VCF2"
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .none
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        let dict: [String: String] = [:]
        return dict
    }
}

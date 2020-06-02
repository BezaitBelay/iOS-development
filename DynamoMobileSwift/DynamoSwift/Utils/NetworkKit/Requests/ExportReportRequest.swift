// 
//  ExportReportRequest.swift
//  DynamoSwift
//
//  Created by Rumyana Atanasova on 20.12.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import UIKit

class ExportReportRequest: BaseAPIRequest {
    override public var timeout: TimeInterval {
           return 60
    }
    
    override public var httpMethod: HTTPMethod {
        return .get
    }
    
    override public var baseUrl: BaseURL {
        return APIManager.shared.baseURLs.baseUrl
    }
    
    override public var path: String {
        return ""
    }
    override var shouldHandleCookies: Bool? {
        return true
    }
    
    override public var authorizationRequirement: AuthorizationRequirement {
        return .none
    }
    
    override public var shouldCache: Bool {
        return false
    }
    
    override public var headers: [String: String] {
        return [:]
    }
}

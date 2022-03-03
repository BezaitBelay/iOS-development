//
//  Servers.swift
//  NetworkKit
//
//  Created by Valentin Kalchev on 31.05.18.
//  Copyright © 2018 Valentin Kalchev. All rights reserved.
//

import Foundation

public enum Environment: String {
    case dev, stage
    
    public var value: EnvironmentInterface {
        switch self {
        case .dev: return DevEnvironment()
        case .stage: return StageEnvironment()
        }
    }
    
    public static let allValues: [Environment] = [dev, stage]
}

public enum CustomBaseUrlType: String {
    case login
    case inApp
    case none
}

public protocol EnvironmentInterface {
    var name: String {get set}
    var baseURLs: BaseURLs {get set}
}

public struct ApiComponents {
    static let version = "/api/v2.1"
}

public typealias BaseURL = String
public protocol BaseURLs {
    var newClUrl: BaseURL {get set}
    var baseUrl: BaseURL {get set}
    var businessCardUrl: BaseURL {get set}
}

/*************************************/
// - MARK: Dev Environment
/*************************************/

struct DevEnvironment: EnvironmentInterface {
    var name = "Development"
    var baseURLs: BaseURLs = DevBaseURLs()
}

struct DevBaseURLs: BaseURLs {
    // Rome
    var newClUrl = "https://dynamo-in.dynamosoftware.com"
    // Prod
    //    var newClUrl = "https://dynamo.dynamosoftware.com"
    // internal url for tests before rome
    //    var newClUrl = "https://dynamoweb1.netagesolutions.com:1111"
    //    var baseUrl = "https://api.dynamosoftware.com"
    //    var baseUrl = "https://apiuat.dynamosoftware.com"
    var baseUrl = "http://10.1.2.211:82"
    var businessCardUrl = "https://bcr1.intsig.net"
}

/*************************************/
// - MARK: Stage Environment
/*************************************/

struct StageEnvironment: EnvironmentInterface {
    var name = "Stage"
    var baseURLs: BaseURLs = StageBaseURLs()
}

struct StageBaseURLs: BaseURLs {
    var newClUrl = "https://dynamo.dynamosoftware.com"
    var baseUrl = "https://apiuat.dynamosoftware.com"
    var businessCardUrl = "https://bcr1.intsig.net"
}

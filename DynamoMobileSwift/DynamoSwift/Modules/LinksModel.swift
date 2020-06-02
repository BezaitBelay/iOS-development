//
//  LinksModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct Links: Codable {
    let link: String
    let nextLink: String?
    
    enum CodingKeys: String, CodingKey {
        case link = "self"
        case nextLink = "next"
    }
}

//
//  EntitiesListModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct EntitiesListModel: Codable {
    let success: Bool
    let links: Links
    let data: [EntityModel]
}

struct EntityModel: Codable, Comparable {
    let name, label: String
    let identity: String?
    let isRelation: Bool
    var permissions: Permissions?
    var subtitleType: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case label = "Label"
        case identity = "IdentityName"
        case isRelation = "IsRelation"
        case permissions = "Permissions"
    }
    
    static func == (lhs: EntityModel, rhs: EntityModel) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: EntityModel, rhs: EntityModel) -> Bool {
        return lhs.label < rhs.label
    }
}

struct Permissions: Codable {
    var read, create, update, delete, permissive: Bool?
}

//
//  Contact.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct EntityData: Codable {
    let success: Bool
    let links: Links?
    let data: [Contact]
    let error: String?
}

struct Contact: Codable {
    var id: String
    var es: String
    var name: String
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case es = "_es"
        case name = "Identifier"
    }
}

struct Links: Codable {
    let link: String
    let nextLink: String?
    
    enum CodingKeys: String, CodingKey {
        case link = "self"
        case nextLink = "next"
    }
}

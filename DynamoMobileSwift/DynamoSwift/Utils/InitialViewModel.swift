//
//  InitialViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct InitialViewsModel: Codable {
    let success: Bool
    let data: [InitialViews]
    let error: String?
}

struct InitialViews: Codable {
    let id, layoutKey, text, qtip: String
    let expanded: Bool?
    let what: ChildWhat?
    let modified: Bool?
    let index: Int?
    let leaf: Bool?
    let iconCls: String?
    let allowDelete, allowRename, allowDrag: Bool?
    let children: [ViewData]
    
}

struct ViewData: Codable {
    let id, layoutKey, text, qtip: String
    let expanded: Bool?
    let what: ChildWhat?
    let modified, leaf: Bool?
    let iconCls: String?
    let index: Int?
    let children: [ViewData]?
}

struct ChildWhat: Codable {
    let es: String?
    let type: String?
    let viewName: String?
}

struct ViewListItem: BaseEntityModel {
    var id, es: String
    var identifier, name: String?
    var subtitle: String?
    var viewData: ViewData
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case es = "_es"
        case identifier = "Identifier"
        case viewData = "viewData"
        case name = "Name"
    }
}

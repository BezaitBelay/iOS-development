//
//  GenericPropertiesForCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import MessageUI

protocol ItemFieldCellModel: Codable {
    var propertyName: String? { get set }
    var propertyValue: String? { get set }
    var propertyPosition: Int { get set }
    var isEditing: Bool { get set }
    
}

class ItemField: ItemFieldCellModel {
    var propertyName: String?
    var propertyValue: String?
    var propertyPosition: Int
    var isEditing: Bool = false
    
    init(key: String, value: String, position: Int, isEditing: Bool) {
        propertyName = key
        propertyValue = value
        propertyPosition = position
        self.isEditing = isEditing
    }
}

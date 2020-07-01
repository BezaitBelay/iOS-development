//
//  GenericPropertiesForCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ItemFieldCellModel {
    var propertyName: String? { get set }
    var propertyValue: String? { get set }
    var propertyPosition: Int { get set }
    var isEditing: Bool { get set }
    var isReadOnly: Bool { get set }
    
    var newValue: Observable<String?> { get set }
    
}

class ItemField: ItemFieldCellModel {
    var propertyName: String?
    var propertyValue: String?
    var propertyPosition: Int
    var isEditing: Bool = false
    var isReadOnly: Bool
    
    var newValue = Observable<String?>(nil)
    
    init(key: String, value: String, position: Int, isEditing: Bool) {
        propertyName = key
        propertyValue = value
        propertyPosition = position
        self.isEditing = isEditing
        isReadOnly = key == ContactDetailSorting.companyName.label
    }
}

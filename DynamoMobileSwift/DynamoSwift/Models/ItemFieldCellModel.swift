//
//  GenericPropertiesForCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

protocol ItemFieldCellModel {
    var propertyName: String { get set }
    var propertyValue: String { get set }
}

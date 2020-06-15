//
//  ContactDetailTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactDetailCellConfigurator = BaseViewConfigurator<ContactDetailTableViewCell>

class ContactDetailTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueTextField: UITextField!
    @IBOutlet weak var view: UIView!
    
    func configureWith(_ data: ItemFieldCellModel) {
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.text = data.propertyValue
        propertyValueTextField.isEnabled = data.isEditing
        propertyValueTextField.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
//        propertyValueTextField.textColor = data.isEditing ? #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) : #colorLiteral(red: 0.564, green: 0.573, blue: 0.6, alpha: 1)
//        propertyValueTextField.borderWidth = data.isEditing ? 1.0 : 0.0
    }
}

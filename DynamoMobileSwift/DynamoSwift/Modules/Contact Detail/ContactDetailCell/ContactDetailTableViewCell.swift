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
    var model: ItemField?
    
    func configureWith(_ data: ItemFieldCellModel) {
        let isEditingEnabled = data.isEditing && !data.isReadOnly
        guard let convertedData = data as? ItemField else { return }
        model = convertedData
        propertyValueTextField.text = convertedData.newValue.value ?? data.propertyValue
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.isEnabled = isEditingEnabled
        propertyValueTextField.backgroundColor = isEditingEnabled ? #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.backgroundColor = isEditingEnabled ? #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    @IBAction func propertyValueIsEditing(_ sender: UITextField) {
        model?.newValue.value = sender.text
    }
}

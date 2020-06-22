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
        guard propertyNameLabel.text != ContactDetailSorting.companyName.label else { return }
        if let model = model?.newValue.value {
            propertyValueTextField.text = model
        } else {
            guard let existing = data as? ItemField else { return }
            model = existing
            propertyValueTextField.text = data.propertyValue
        }
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.isEnabled = data.isEditing
        propertyValueTextField.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
    }
    
    @IBAction func propertyValueIsEditing(_ sender: UITextField) {
        model?.newValue.value = sender.text
    }
}

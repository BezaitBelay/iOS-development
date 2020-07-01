//
//  ContactDetailWithActionTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 12.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactDetailWithActionCellConfigurator = BaseViewConfigurator<ContactDetailWithActionTableViewCell>

class ContactDetailWithActionTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueTextField: UITextField!
    @IBOutlet weak var view: UIView!
    @IBOutlet var picture: UIImageView!
    var model: ItemField?
    
    func configureWith(_ data: ItemFieldCellModel) {
        let isEditingEnabled = data.isEditing && !data.isReadOnly
        guard let convertedData = data as? ItemField else { return }
        model = convertedData
        propertyValueTextField.text = convertedData.newValue.value ?? data.propertyValue
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.isEnabled = data.isEditing
        propertyValueTextField.backgroundColor = isEditingEnabled ? #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.backgroundColor = isEditingEnabled ? #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        picture.isHidden = isEditingEnabled
        pickKeyboardType(for: data.propertyName ?? "")
    }
    
    @IBAction func textFieldIsChanging(_ sender: UITextField) {
         model?.newValue.value = sender.text
    }
    
    func pickKeyboardType(for label: String) {
        switch label {
        case ContactDetailSorting.contactInfoCompanyLink.label:
            propertyValueTextField.keyboardType = UIKeyboardType(rawValue: 10) ?? .default
        case ContactDetailSorting.primarycontactemail.label:
            propertyValueTextField.keyboardType = UIKeyboardType(rawValue: 7) ?? .default
        case ContactDetailSorting.primarycontactphone.label:
            propertyValueTextField.keyboardType = UIKeyboardType(rawValue: 5) ?? .default
        default:
            return
        }
    }
}

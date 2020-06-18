//
//  ContactDetailWithActionTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 12.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactDetailWithActionCellConfigurator = BaseViewConfigurator<ContactDetailWithActionTableViewCell>

class ContactDetailWithActionTableViewCell: UITableViewCell, Configurable, CellDataProtocol {
    
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueTextField: UITextField!
    @IBOutlet weak var view: UIView!
    @IBOutlet var kartinka: UIImageView!
    
    func configureWith(_ data: ItemFieldCellModel) {
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.text = data.propertyValue
        propertyValueTextField.isEnabled = data.isEditing
        propertyValueTextField.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        kartinka.isHidden = data.isEditing
        pickKeyboardType(for: data.propertyName ?? "")
    }
    
    func populateData() -> [String: String] {
        return [propertyNameLabel.text ?? "": propertyValueTextField.text ?? ""]
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

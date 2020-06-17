//
//  ContactDetailTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactDetailCellConfigurator = BaseViewConfigurator<ContactDetailTableViewCell>

protocol CellDataDelegate: class {
   
}

protocol CellDataProtocol: class {
    func populateData() -> [String: String]
}

class ContactDetailTableViewCell: UITableViewCell, Configurable, CellDataProtocol {
    
    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueTextField: UITextField!
    @IBOutlet weak var view: UIView!
    
    func configureWith(_ data: ItemFieldCellModel) {
        guard propertyNameLabel.text != ContactDetailSorting.companyName.label else { return }
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.text = data.propertyValue
        propertyValueTextField.isEnabled = data.isEditing
        propertyValueTextField.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
    }
    
    func populateData() -> [String: String] {
        return [propertyNameLabel.text ?? "": propertyValueTextField.text ?? ""]
    }
}

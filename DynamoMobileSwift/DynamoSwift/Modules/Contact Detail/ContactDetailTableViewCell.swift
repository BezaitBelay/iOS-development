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
    
    func configureWith(_ data: ItemFieldCellModel) {
        propertyNameLabel.text = data.propertyName
        propertyValueTextField.text = data.propertyValue
    }
}

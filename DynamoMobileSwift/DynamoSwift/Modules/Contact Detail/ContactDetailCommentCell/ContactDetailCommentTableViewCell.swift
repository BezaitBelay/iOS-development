//
//  ContactDetailCommentTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 12.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactDetailCommentCellConfigurator = BaseViewConfigurator<ContactDetailCommentTableViewCell>

class ContactDetailCommentTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueTextView: UITextView!
    @IBOutlet weak var view: UIView!
    
    func configureWith(_ data: ItemFieldCellModel) {
        propertyNameLabel.text = data.propertyName
        propertyValueTextView.text = data.propertyValue
        propertyValueTextView.isEditable = data.isEditing
        propertyValueTextView.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
//        propertyValueTextView.textColor = data.isEditing ? #colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0) : #colorLiteral(red: 0.564, green: 0.573, blue: 0.6, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
    }
}

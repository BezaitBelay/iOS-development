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
    var model: ItemField?
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        propertyValueTextView.delegate = self
    }
    
    func configureWith(_ data: ItemFieldCellModel) {
        if let value = model?.newValue.value {
            propertyValueTextView.text = value
        } else {
            guard let existing = data as? ItemField else { return }
            model = existing
            propertyValueTextView.text = data.propertyValue
        }
        propertyNameLabel.text = data.propertyName
        propertyValueTextView.isEditable = data.isEditing
        propertyValueTextView.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
        view.backgroundColor = !data.isEditing ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.909, green: 0.909, blue: 0.929, alpha: 1)
    }
}

extension ContactDetailCommentTableViewCell: UITextViewDelegate {
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
        model?.newValue.value = textView.text
    }
}

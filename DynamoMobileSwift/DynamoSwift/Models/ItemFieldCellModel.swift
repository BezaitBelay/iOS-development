//
//  GenericPropertiesForCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import MessageUI

protocol ItemFieldCellModel: Codable {
    var propertyName: String? { get set }
    var propertyValue: String? { get set }
    var propertyPosition: Int { get set }
    var isEditing: Bool { get set }
}

class ItemField: ItemFieldCellModel {
    var propertyName: String?
    var propertyValue: String?
    var propertyPosition: Int
    var isEditing: Bool = false
    
    init(key: String, value: String, position: Int, isEditing: Bool) {
        propertyName = key
        propertyValue = value
        propertyPosition = position
        self.isEditing = isEditing
    }
}

class MailField: ItemFieldCellModel {
    var propertyName: String?
    var propertyValue: String?
    var propertyPosition: Int
    var isEditing: Bool
    
    init(key: String, value: String, position: Int, isEditing: Bool) {
        propertyName = key
        propertyValue = value
        propertyPosition = position
        self.isEditing = isEditing
    }
    
    func didSelectAction() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeViewController = MFMailComposeViewController()
            if let propertyValue = propertyValue {
                mailComposeViewController.setToRecipients([propertyValue])
                mailComposeViewController.setSubject("Cheers!")
            }
//            present(mailComposeViewController,animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Not available!", message: "Mail services are not configured", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
        }
    }
}

//
//  ContactsTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias ContactCellConfigurator = BaseViewConfigurator<ContactsTableViewCell>

class ContactsTableViewCell: UITableViewCell, Configurable {
    @IBOutlet weak var entityTypeLabel: UILabel!
    @IBOutlet weak var entityNameLabel: UILabel!
    @IBOutlet weak var entityIconLabel: UILabel!
    
    func configureWith(_ data: Contact) {
        entityTypeLabel.text = data.es
        entityNameLabel.text = data.name
        entityIconLabel.text = "К"
        entityIconLabel.textColor = UIColor.white
        entityIconLabel.backgroundColor = #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1)
        entityIconLabel.layer.cornerRadius = entityIconLabel.frame.width/2
        entityIconLabel.layer.masksToBounds = true
    }
}

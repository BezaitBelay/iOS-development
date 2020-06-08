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
    func configureWith(_ data: ContactCellModel) {
        textLabel?.text = data.id
        detailTextLabel?.text = data.es
    }
}

class ContactCellModel {
    var id: String
    var es: String
    
    init(id: String, es: String) {
        self.id = id
        self.es = es
    }
}

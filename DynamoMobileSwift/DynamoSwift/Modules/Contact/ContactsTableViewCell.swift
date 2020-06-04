//
//  ContactsTableViewCell.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    func configureWith(_ data: ContactsCellViewModel) {
        textLabel?.text = data.id
        detailTextLabel?.text = data.es
    }
}

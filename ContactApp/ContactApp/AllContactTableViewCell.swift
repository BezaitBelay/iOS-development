//
//  FamilyTableViewCell.swift
//  ContactApp
//
//  Created by Dynamo Software on 12.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class AllContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateContact(with contact: Contact) {
        contactImage.image = contact.picture ?? UIImage(named: "img0")
        contactNameLabel.text = contact.fullName
        contactPhoneLabel.text = contact.phoneNumber
        contactEmailLabel.text = contact.email
    }
}

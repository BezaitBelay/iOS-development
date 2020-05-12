//
//  FamilyTableViewCell.swift
//  ContactApp
//
//  Created by Dynamo Software on 12.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class FamilyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var familyImage: UIImageView!
    @IBOutlet weak var familyNameLabel: UILabel!
    @IBOutlet weak var familyPhoneLabel: UILabel!
    @IBOutlet weak var familyEmailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateFamilyContact(with contact: Contact) {
        familyImage.image = contact.picture ?? UIImage.self(named: "img0")
        familyNameLabel.text = contact.fullName
        familyPhoneLabel.text = contact.phoneNumber
        familyEmailLabel.text = contact.email
    }
}

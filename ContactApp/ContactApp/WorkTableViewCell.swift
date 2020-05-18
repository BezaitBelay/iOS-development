//
//  WorkTableViewCell.swift
//  ContactApp
//
//  Created by Dynamo Software on 12.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var workImage: UIImageView!
    @IBOutlet weak var workPhoneLabel: UILabel!
    @IBOutlet weak var workNameLabel: UILabel!
    @IBOutlet weak var workEmailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateWorkContact(with contact: Contact) {
        workImage.image = contact.picture ?? UIImage.self(named: "img0")
        workPhoneLabel.text = contact.phoneNumber
        workNameLabel.text = contact.fullName
        workEmailLabel.text = contact.email
    }
    
}

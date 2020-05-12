//
//  FriendsTableViewCell.swift
//  ContactApp
//
//  Created by Dynamo Software on 12.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendPhoneLabel: UILabel!
    @IBOutlet weak var friendEmailLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateFriendContact(with contact: Contact) {
        friendImage.image = contact.picture ?? UIImage.self(named: "img0")
        friendPhoneLabel.text = contact.phoneNumber
        friendNameLabel.text = contact.fullName
        friendEmailLabel.text = contact.email
    }
    
    
    
}

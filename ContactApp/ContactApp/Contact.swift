//
//  Contact.swift
//  ContactApp
//
//  Created by Dynamo Software on 8.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class Contact {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var homeAddress: String?
    var picture: UIImage?
    var group: Group
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String, phoneNumber: String, email: String, homeAddress: String?, picture: UIImage?, group: Group) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.homeAddress = homeAddress
        self.picture = picture
        self.group = group
    }
    
    
    
}


enum Group: String {
    case family = "Family"
    case work = "Work"
    case friends = "Friends"
}

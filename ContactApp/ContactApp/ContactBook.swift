//
//  ContactBook.swift
//  ContactApp
//
//  Created by Dynamo Software on 8.05.20.
//  Copyright © 2020 Dynamo Software. All rights reserved.
//

import UIKit

class ContactBook {
    static let shared = ContactBook()

    var contacts: [Contact]
    var count: Int {
        contacts.count
    }
    private init() {
        contacts = [
            Contact(firstName: "Georgi", lastName: "Georgiev", phoneNumber: "0988876544", email: "gosho@gmail.com", homeAddress: "Sofia, bl. 310, ap. 15", picture:UIImage.self(named: "img2") , group: .friend),
            Contact(firstName: "Maria", lastName: "Petrova", phoneNumber: "0876512345", email: "maria@abv.bg", homeAddress: "Plovdiv, ulica Stara Planina No 15", picture: UIImage.self(named: "img3"), group: .family),
            Contact(firstName: "Aleksander", lastName: "Marinov", phoneNumber: "0887654234", email: "sasho@gmail.com", homeAddress: nil, picture: nil /*UIImage.self(named: "img4")*/, group: .work),
            Contact(firstName: "Carla", lastName: "Perez", phoneNumber: "0887223498", email: "carla@gmail.com", homeAddress: nil, picture: UIImage.self(named: "img1"), group: .work),
        ]
    }
    
    func append(contact: Contact) {
        contacts.append(contact)
    }
    
    func removeAt(at index: Int) {
        contacts.remove(at: index)
    }
    
    
}

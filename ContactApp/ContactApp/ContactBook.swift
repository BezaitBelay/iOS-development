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
            Contact(firstName: "Georgi", lastName: "Georgiev", phoneNumber: "0988876544", email: "gosho@gmail.com", homeAddress: "Sofia, bl. 310, ap. 15", picture:UIImage(named: "img2") , group: .friends),
            Contact(firstName: "Maria", lastName: "Petrova", phoneNumber: "0876512345", email: "maria@abv.bg", homeAddress: "Plovdiv, ulica Stara Planina No 15", picture: UIImage(named: "img3"), group: .family),
            Contact(firstName: "Aleksander", lastName: "Marinov", phoneNumber: "0887654234", email: "sasho@gmail.com", homeAddress: nil, picture: nil /*UIImage(named: "img4")*/, group: .work),
            Contact(firstName: "Carla", lastName: "Perez", phoneNumber: "0887223498", email: "carla@gmail.com", homeAddress: nil, picture: UIImage(named: "img1"), group: .work),
        ]
    }
    
    subscript(index: IndexPath) -> Contact {
        get {
            getContactBy(indexPath: index)
        }
        set(newValue) {
            guard let contactIndex = contacts.firstIndex(of: getContactBy(indexPath: index)) else {return}
            contacts[contactIndex] = newValue
        }
    }
    
    subscript(index: Int) -> Contact {
        get {
            contacts[index]
        }
        set(newValue) {
            contacts[index] = newValue
        }
    }

    func splitContactsInGroups() -> [[Contact]] {
        return [getContactListBy(group: .family),getContactListBy(group: .work), getContactListBy(group: .friends)]
    }
    
    func append(contact: Contact) {
        contacts.append(contact)
    }
    
    func removeAt(at index: IndexPath) {
        guard let contactIndex = contacts.firstIndex(of: getContactBy(indexPath: index)) else {return}
        contacts.remove(at: contactIndex)
    }
    
    func getContactBy(indexPath: IndexPath) -> Contact {
        let contactInGroup = getContactListBy(groupNumber: indexPath.section)
        return contactInGroup[indexPath.row]
    }
    
    func getContactListBy(group: Group) -> [Contact]{
        return contacts.filter({$0.group == group})
    }
    
    func sorted() -> [Contact]{
        return contacts.sorted(by: {$0.fullName < $1.fullName})
    }
    
    private func getContactListBy(groupNumber: Int) -> [Contact] {
        return contacts.filter({$0.group.number == groupNumber})
    }
}

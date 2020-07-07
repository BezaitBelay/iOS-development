//
//  UserDefaultHelper.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 23.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

class UserDefaultRepository {
    static func getContacts<T: Codable>(of type: T.Type, for key: String) -> [T]? {
        let objects: [T]
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            objects = (try? decoder.decode(Array.self, from: data) as [T]) ?? []
        } else {
            objects = []
        }
        
        return objects
    }
    
    static func saveRecentContact(_ contact: Contact) {
        guard var items = UserDefaultRepository.getContacts(of: Contact.self, for: Constants.Storyboards.contacts) else { return }
        if items.isEmpty {
            let encoder = JSONEncoder()
            let array = [contact]
            if let encoded = try? encoder.encode(array) {
                UserDefaults.standard.set(encoded, forKey: Constants.Storyboards.contacts)
            }
        } else {
            if items.first(where: {$0.id == contact.id}) != nil {
                items.removeAll(where: {$0.id == contact.id})
            }
            items.insert(contact, at: 0)
            let encoder = JSONEncoder()
            let index = items.count > 20 ? 20 : items.count
            let array = Array(items[..<index])
            if let encoded = try? encoder.encode(array) {
                UserDefaults.standard.set(encoded, forKey: Constants.Storyboards.contacts)
            }
        }
    }
    
    static func removeFromRecent(_ contact: Contact, completion: (() -> Void)?) {
        guard var items = UserDefaultRepository.getContacts(of: Contact.self, for: Constants.Storyboards.contacts), !items.isEmpty else { return }
        if items.first(where: {$0.id == contact.id}) != nil {
            items.removeAll(where: {$0.id == contact.id})
        }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: Constants.Storyboards.contacts)
        }
        guard let completion = completion else { return }
        completion()
    }
}

//
//  UserDefaultHelper.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 23.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

class UserDefaultHelper {
    static func getObjectsArray<T: Codable>(of type: T.Type, for key: String) -> [T]? {
        let objects: [T]
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            objects = (try? decoder.decode(Array.self, from: data) as [T]) ?? []
        } else {
            objects = []
        }
        
        return objects.count > 20 ? Array(objects[..<20]) : objects
    }
    
    static func saveRecentContact(_ contact: Contact) {
        //                        UserDefaults.standard.removeObject(forKey: Constants.Storyboards.contacts)
        
        guard var items = UserDefaultHelper.getObjectsArray(of: Contact.self, for: Constants.Storyboards.contacts) else { return }
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
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: Constants.Storyboards.contacts)
            }
        }
    }
}

//
//  UserDefaultsRepository.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

protocol UserDefaultsRepositoryProtocol {
    func getString(for key: String) -> String?
    func getValue<T>(of type: T.Type, for key: String) -> T?
    func getObject<T: Codable>(of type: T.Type, for key: String) -> T?
    func getObjectsArray<T: Codable>(of type: T.Type, for key: String) -> [T]
    func getData(for key: String) -> Data?
    func getInt(for key: String) -> Int?
    func getBool(for key: String) -> Bool?
    func setValue(_ value: Any?, for key: String)
    func setObjectValue<T: Codable>(_ value: T, for key: String)
    func setObjectsArray<T: Codable>(_ value: [T], for key: String)
    func removeValue(for key: String)
    
    //func getUserDataWithCheck(shouldRememberMeIsOn: Bool) -> UserData?
}

class UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    func getString(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func getValue<T>(of type: T.Type, for key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
    
    func getObject<T: Codable>(of type: T.Type, for key: String) -> T? {
        let object: T?
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            object = try? decoder.decode(type, from: data)
        } else {
            object = nil
        }
        return object
    }
    
    func getObjectsArray<T: Codable>(of type: T.Type, for key: String) -> [T] {
        let objects: [T]
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            objects = (try? decoder.decode(Array.self, from: data) as [T]) ?? []
        } else {
            objects = []
        }
        return objects
    }
    func getBool(for key: String) -> Bool? {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func getInt(for key: String) -> Int? {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func getData(for key: String) -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
    
    func setValue(_ value: Any?, for key: String) {
        if value as? NSCoding == nil, value != nil {
            preconditionFailure("Value should conform to NSCoding.")
        }
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func setObjectValue<T: Codable>(_ value: T, for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func setObjectsArray<T: Codable>(_ value: [T], for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func removeValue(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
//    func getUserDataWithCheck(shouldRememberMeIsOn: Bool) -> UserData? {
//        let userData: UserData?
//        let rememberMe = getBool(for: Constants.UserDefaultKeys.rememberMe) ?? false
//        let shouldExtract = (rememberMe && shouldRememberMeIsOn) || !shouldRememberMeIsOn
//        if shouldExtract {
//            userData = getObject(of: UserData.self,
//                                 for: Constants.UserDefaultKeys.userData)
//        } else {
//            userData = nil
//        }
//        return userData
//    }
}

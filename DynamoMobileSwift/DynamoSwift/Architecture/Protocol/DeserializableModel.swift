//
//  DeserializableModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

/**
    Functional protocol defining that the instances of the implementing classes could be initialized by deserializing from a passed JSON
 */
protocol DeserializableModel {
    static func fromJSON(_ jsonData: [String: Any]?) -> DeserializableModel?
}

extension DeserializableModel {
    
    /**
        Method for building arrays of DeserializableModels from given array of Dictionaries by calling T.fromJSON().
        Method uses Generics and the class type should be passed to work properly
    */
    static func buildArray(_ jsonData: [[String: Any]]?) -> [Self] {
        var array: [Self] = []
        guard let jsonData = jsonData else { return array }
        
        for tData in jsonData {
            guard let tElement = Self.fromJSON(tData) as? Self else { continue }
            array.append(tElement)
        }
        return array
    }
    
    static func convertJsonDataToArray(_ jsonData: [String: Any], for key: String) -> [[String: Any]]? {
        let data: [[String: Any]]?
        if let jsonArray = jsonData[key] as? [[String: Any]] {
            data = jsonArray
        } else {
            let dictionaryData = jsonData[key] as? [String: Any]
            data = [dictionaryData] as? [[String: Any]]
        }
        return data
        
    }
}

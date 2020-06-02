//
//  PickerItemsModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseEntityModel: Codable {
    var id: String {get set}
    var es: String {get set}
    var identifier: String? {get set}
    var name: String? {get set}
    var subtitle: String? {get set}
}

class PickerItemsModel: Codable {
    var error: String?
    var success: Bool = false
    var links: Links?
    var total: Int?
    var data: [PickerItem]?
}

class PickerItem: Equatable, DeserializableModel, BaseEntityModel {
    static func == (lhs: PickerItem, rhs: PickerItem) -> Bool {
        return lhs.identifier == rhs.identifier && lhs.id == rhs.id
    }
    
    var id = ""
    var es = ""
    var name: String? = ""
    var entityKey, isSystem: String?
    var identifier: String?
    var displayOrder: Int?
    var order: Int {
        return displayOrder ?? 0
    }
    var subtitle: String?
    
    init() {}
    
    init(with identifier: String, id: String? = nil, es: String? = nil, subtitle: String? = nil) {
        self.id = id ?? ""
        self.es = es ?? ""
        self.identifier = identifier
        self.subtitle = subtitle
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case es = "_es"
        case entityKey = "EntityKey"
        case displayOrder = "DisplayOrder"
        case isSystem = "IsSystem"
        case identifier = "Identifier"
    }
    
    static func fromJSON(_ jsonData: [String: Any]?) -> DeserializableModel? {
        guard var json = jsonData else { return nil }
        let item = PickerItem()
        item.id = jsonData?["_id"] as? String ?? jsonData?["id"] as? String ?? ""
        json.removeValue(forKey: "_id")
        item.es = jsonData?["_es"] as? String ?? jsonData?["es"] as? String ?? ""
        json.removeValue(forKey: "_es")
        item.entityKey = jsonData?["EntityKey"] as? String
        json.removeValue(forKey: "EntityKey")
        item.displayOrder = jsonData?["DisplayOrder"] as? Int
        json.removeValue(forKey: "DisplayOrder")
        item.isSystem = jsonData?["IsSystem"] as? String
        json.removeValue(forKey: "IsSystem")
        item.identifier = jsonData?["Identifier"] as? String ?? jsonData?["name"] as? String ?? jsonData?["Name"] as? String
        json.removeValue(forKey: "Identifier")
//        let subtitleKey = EntitiesManager.shared.getEntitySubtitleTypeFor(name: item.es) ?? ""
//        item.subtitle = jsonData?[subtitleKey] as? String
//        json.removeValue(forKey: subtitleKey)
        if json.count == 1, item.identifier == nil {
            item.identifier = json.first?.value as? String
        }
        return item
    }
    
    func toJSON() -> [String: Any] {
        var dict: [String: Any] =  [:]
        dict["_id"] = self.id
        dict["_es"] = self.es
        dict["Name"] = self.identifier
        return dict
    }
    
    var hasEmptyElements: Bool {
        return id.isEmpty || es.isEmpty || identifier == nil || identifier?.isEmpty == true
    }
}

class PickerDataObject: Object {
    @objc dynamic var identifier: String?
    @objc dynamic var pickerData: Data?
    
    override static func primaryKey() -> String? {
        return "identifier"
    }
    
    var extractedPickerDataModel: PickerItemsModel? {
        guard let pickerData = pickerData else {return nil}
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return try? decoder.decode(PickerItemsModel.self, from: pickerData)
    }
}

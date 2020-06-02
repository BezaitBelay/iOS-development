//
//  EntityListDataModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

struct EntityListDataModel: Codable {
    let success: Bool
    let links: Links?
    let total: Int?
    let data: [EntityListItem]?
    let error: String?
}

struct EntityListItem: Equatable, BaseEntityModel {
    var id, es: String
    var identifier: String?
    var name: String?
    //document properties
    var filename: String?
    var docDate: String?
    var docSize: String?
    //activity item propeerties
    var createdBy: String?
    var subject: String?
    var type: String?
    var body: String?
    var date: String?
    //views
    var message: String?
    
    var subtitle: String?
    
    init(id: String, es: String, identifier: String?, name: String? = nil, subtitle: String? = nil) {
        self.id = id
        self.es = es
        self.identifier = identifier ?? name
        self.name = name
        self.subtitle = subtitle
        filename = ""
        docDate = ""
        docSize = ""
        createdBy = ""
        subject = ""
        type = ""
        body = ""
        date = ""
        message = ""
    }
    
    init?(with data: [String: Any]?) {
        guard let data = data else { return nil }
        
        id = data["_id"] as? String ?? ""
        es = data["_es"] as? String ?? ""
        identifier = data["Identifier"] as? String
        name = data["Name"] as? String
        body = data["Body_PlainText"] as? String ?? data["Body"] as? String
        subject = data["Subject"] as? String
        type = data["Type"] as? String
        date = data["Date"] as? String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case es = "_es"
        case identifier = "Identifier"
        case name = "Name"
        case filename = "Filename"
        case docDate = "Documentdate"
        case docSize = "Size"
        case createdBy = "CreatedBy"
        case subject = "Subject"
        case type = "Type"
        case body = "Body_PlainText"
        case date = "Date"
        case message = "Message"
        case subtitle = "subtitle"
    }
    
//    init(from decoder: Decoder) throws {
//        let dynamicKeysContainer = try decoder.container(keyedBy: DynamicKey.self)
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.es = try container.decode(String.self, forKey: .es)
//        self.identifier = try? container.decode(String.self, forKey: .identifier)
//        self.name = try? container.decode(String.self, forKey: .name)
//        self.filename = try? container.decode(String.self, forKey: .filename)
//        self.docDate = try? container.decode(String.self, forKey: .docDate)
//        self.docSize = try? container.decode(String.self, forKey: .docSize)
//        self.createdBy = try? container.decode(String.self, forKey: .createdBy)
//        self.subject = try? container.decode(String.self, forKey: .subject)
//        self.type = try? container.decode(String.self, forKey: .type)
//        self.body = try? container.decode(String.self, forKey: .body)
//        self.date = try? container.decode(String.self, forKey: .date)
//        self.message = try? container.decode(String.self, forKey: .message)
//        self.subtitle = try? container.decode(String.self, forKey: .subtitle)
//        guard subtitle == nil else {
//            return
//        }
//        let subtitleKey = EntitiesManager.shared.getEntitySubtitleTypeFor(name: self.es)
//
//        try? dynamicKeysContainer.allKeys.forEach { key in
//            guard key.stringValue == subtitleKey else {return}
//            subtitle = try dynamicKeysContainer.decode(String.self, forKey: key)
//        }
//    }
    
    mutating func updateEntity(with data: [String: Any]?) {
        guard let data = data else { return }
        
        identifier = data["Identifier"] as? String ?? identifier
        name = data["Name"] as? String ?? name
        body = data["Body"] as? String ?? body
        subject = data["Subject"] as? String ?? subject
        type = data["Type"] as? String ?? type
        date = data["Date"] as? String ?? date
      //  subtitle = getSubtitleValueFrom(data: data)
    }
    
//    private func getSubtitleValueFrom(data: [String: Any]?) -> String? {
//        let subtitle: String?
//        let subtitleKey = EntitiesManager.shared.getEntitySubtitleTypeFor(name: self.es) ?? ""
//        if let subtitleValue = data?[subtitleKey] as? String {
//            subtitle = subtitleValue
//        } else if let subtitleValues = data?[subtitleKey] as? [[String: Any]] {
//            subtitle = subtitleValues.compactMap({$0["Name"] as? String }).joined(separator: "; ")
//        } else if let subtitleValue = data?[subtitleKey] as? [String: Any] {
//            subtitle = subtitleValue["Name"] as? String
//        } else {
//            subtitle = nil
//        }
//        return subtitle
//    }
}

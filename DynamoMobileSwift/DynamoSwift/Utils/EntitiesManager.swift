//
//  EntitiesManager.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

class EntitiesManager {
//    static let shared = EntitiesManager()
//
//    private var availableEntities: [EntityModel] = []
//
//    func setEntities(_ entities: [EntityModel]) {
//        availableEntities = entities
//    }
//
//    func getEntityLabelFor(name: String?) -> String? {
//        let entity = availableEntities.first(where: {$0.name == name})
//        return entity?.label
//    }
    
//    func getEntitySubtitleTypeFor(name: String?) -> String? {
//        let entity = availableEntities.first(where: {$0.name == name})
//        let subtitle: String?
//        if entity?.subtitleType != nil {
//            subtitle = entity?.subtitleType
//        } else if let name = name, let defaultSub = getDefaultSubtitleFor(entityType: name) {
//            subtitle = defaultSub
//        } else {
//            subtitle = nil
//        }
//        return subtitle
//    }
//
//    private func getDefaultSubtitleFor(entityType: String) -> String? {
//        let config = LocaleFileHandler().loadJsonObject(of: JSONAny.self, for: "CustomEntityData")
//        let data = config?.value as? [String: Any]
//        let subtitle = (data?[entityType] as? [String: String])?["subtitle"]
//        return subtitle
//    }
}

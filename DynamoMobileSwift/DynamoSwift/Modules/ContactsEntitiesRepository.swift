//
//  ContactsEntitiesRepository.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

private struct ContactsEntitiesConstants {
    fileprivate static let entitiesCount = 20
}

protocol ContactsEntitiesRepositoryProtocol {
//    func addToRecent(entity: BaseEntityModel)
//    @discardableResult func removeFromRecent(entity: BaseEntityModel) -> [EntityListItem]
//    func getAllRecentEntities() -> [EntityListItem]
}

class ContactsEntitiesRepository: ContactsEntitiesRepositoryProtocol {
    private var userDefaultsRepository: UserDefaultsRepository
    private var accountKey: String {
        let userData = userDefaultsRepository.getObject(of: UserData.self,
        for: "userData")
        let username = userData?.username ?? ""
       // let tenant = userData?.selectedTenant?.name ?? ""
        let localUserAccountIdentifier = "\(username)"//"-\(tenant)"
        return localUserAccountIdentifier
    }
//    private var accountInfo: AccountSettings? {
//        let account = DBManager.shared.read(AccountSettings.self,
//                                            query: .identifierEquals(identifier: accountKey))
//        return account.first
//    }
    
    init(userDefaultsRepository: UserDefaultsRepository = UserDefaultsRepository()) {
        self.userDefaultsRepository = userDefaultsRepository
    }
    
//    func addToRecent(entity: BaseEntityModel) {
//        var item: EntityListItem
//        if let entity = entity as? EntityListItem {
//            item = entity
//        } else {
//            // handle more cases if required
//            item = EntityListItem(id: entity.id, es: entity.es, identifier: entity.identifier, subtitle: entity.subtitle)
//        }
//
//        // get entities array from user defaults
//        var entitiesArray = getAllRecentEntities()
//
//        // check if this entity is already in the array and remove it
//        entitiesArray.removeFirst(where: {$0.id == entity.id})
//
//        // check number of entities in array
//        if entitiesArray.count >= RecentEntitiesConstants.entitiesCount {
//            _ = entitiesArray.popLast()
//        }
//
//        // insert entity
//        entitiesArray.insert(item, at: 0)
//
//        // save mutated array
//        save(items: entitiesArray)
//    }
//
//    @discardableResult func removeFromRecent(entity: BaseEntityModel) -> [EntityListItem] {
//        var entitiesArray = getAllRecentEntities()
//        entitiesArray.removeFirst(where: {$0.id == entity.id})
//        save(items: entitiesArray)
//        return entitiesArray
//    }
//
//    func getAllRecentEntities() -> [EntityListItem] {
//        guard let data = accountInfo?.recentItems else {return []}
//        let decoder = JSONDecoder()
//        let objects = (try? decoder.decode(Array.self, from: data) as [EntityListItem]) ?? []
//        return objects
//    }
//
//    // MARK: Private methods
//    private func save(items: [EntityListItem]) {
//        let encoder = JSONEncoder()
//        let recentData = try? encoder.encode(items)
//        DBManager.shared.update(objectType: AccountSettings.self,
//                                query: .identifierEquals(identifier: accountKey)) { (account) in
//            account?.recentItems = recentData
//        }
//    }
}

//
//  RecentViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 17.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class RecentViewModel {
    var shouldShowLoading = Observable<Bool>(false)
    var entities: [Contact] = []
    var shouldReloadTable = Observable<Bool>(false)
    
    init() {
        entities = UserDefaultHelper.getObjectsArray(of: Contact.self, for: Constants.Storyboards.contacts) ?? []
    }
}

extension RecentViewModel: BaseDataSource {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return entities.count
    }
    
    func viewConfigurator(at index: Int, in setion: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        guard entities.count > index else { return nil }
        
        configurator = ContactCellConfigurator(data: entities[index], didSelectAction: nil)
        
        return configurator
    }
}

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
}

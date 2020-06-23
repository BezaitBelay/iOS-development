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
    weak var delegate: ContactsCoordinatorDelegate?
    
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
        
        configurator = ContactCellConfigurator(data: entities[index]) {[weak self] in
            guard let strongSelf = self else { return }
            UserDefaultHelper.saveRecentContact(strongSelf.entities[index])
            strongSelf.shouldShowLoading.value = true
            strongSelf.delegate?.showContactsDetail(strongSelf.entities[index].id, showLoading: strongSelf.shouldShowLoading)
        }
        
        return configurator
    }
}

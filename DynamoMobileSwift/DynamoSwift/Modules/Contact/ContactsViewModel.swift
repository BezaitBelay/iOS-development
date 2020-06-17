//
//  ContactsCellViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ContactsViewModelProtocol: BaseDataSource {
    var entities: [Contact] {get}
    var shouldShowLoading: Observable<Bool> {get set}
    var shouldReloadTable: Observable<Bool> {get set}
}

class ContactsViewModel: ContactsViewModelProtocol {
    var shouldShowLoading = Observable<Bool>(false)
    var entities = [Contact]()
    var shouldReloadTable = Observable<Bool>(false)
    private var currentItemType: String = "contact"
    private var nextPageURL: String?
    private var contactsRepository: ContactsRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactsCoordinatorDelegate?
    
    init(contactsRepository: ContactsRepositoryProtocol) {
        self.contactsRepository = contactsRepository
        shouldShowLoading.value = true
        self.contactsRepository?.getEntitiesOf(type: currentItemType,
                                               nextPageURL: nextPageURL) { [weak self] (itemsResponse) in
                                                print(itemsResponse ?? "itemsResponse is nil")
                                                guard let strongSelf = self else { return }
                                                let entities: [Contact] = itemsResponse?.data ?? []
                                                strongSelf.entities = entities.sorted { $0.name.lowercased() < $1.name.lowercased() }
                                                strongSelf.nextPageURL = itemsResponse?.links?.nextLink
                                                strongSelf.shouldReloadTable.value = true
                                                strongSelf.shouldShowLoading.value = false
        }
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return entities.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        let cellModel = entities[index]
        configurator = ContactCellConfigurator(data: cellModel) {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.shouldShowLoading.value = true
            strongSelf.delegate?.showContactsDetail(cellModel, showLoading: strongSelf.shouldShowLoading, contactId: cellModel.id)
        }
        
        return configurator
    }
    
    func requestNextPageWhen(index: Int) {
        guard index == entities.count - 1, nextPageURL != nil else { return }
        shouldShowLoading.value = true
        contactsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { [weak self] (itemsResponse) in
            print(itemsResponse ?? "itemsResponse is nil")
            guard let strongSelf = self else { return }
            strongSelf.entities.append(contentsOf: itemsResponse?.data ?? [])
            strongSelf.nextPageURL = itemsResponse?.links?.nextLink
            strongSelf.shouldShowLoading.value = false
            strongSelf.shouldReloadTable.value = true
        }
    }
}

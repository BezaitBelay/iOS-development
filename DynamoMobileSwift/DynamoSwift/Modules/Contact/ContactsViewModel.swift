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
    var shouldHideTable: Observable<Bool> { get set }
}

class ContactsViewModel: ContactsViewModelProtocol {
    var entities: [Contact] = []
    var shouldReloadTable = Observable<Bool>(false)
    var shouldShowLoading = Observable<Bool>(false)
    var shouldHideTable = Observable<Bool>(false)
    private let currentItemType: String = "contact"
    private var nextPageURL: String?
    private var contactsRepository: ContactsRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactsCoordinatorDelegate?
    
    init(contactsRepository: ContactsRepositoryProtocol) {
        self.contactsRepository = contactsRepository
        shouldHideTable.value = true
        shouldShowLoading.value = true
        self.contactsRepository?.getEntitiesOf(type: currentItemType,
                                               nextPageURL: nextPageURL) { [weak self] (itemsResponse) in
                                                guard let strongSelf = self else { return }
                                                strongSelf.entities = itemsResponse?.data ?? []
                                                strongSelf.nextPageURL = itemsResponse?.links?.nextLink
                                                strongSelf.shouldReloadTable.value = true
                                                strongSelf.shouldHideTable.value = false
                                                strongSelf.shouldShowLoading.value = false
        }
    }
    
    
    func requestNextPageWhen(index: Int) {
        guard index == entities.count - 1, nextPageURL != nil else { return }
        contactsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { [weak self] (itemsResponse) in
            //            print(itemsResponse ?? "itemsResponse is nil")
            guard let strongSelf = self else { return }
            strongSelf.entities.append(contentsOf: itemsResponse?.data ?? [])
            strongSelf.nextPageURL = itemsResponse?.links?.nextLink
            strongSelf.shouldReloadTable.value = true
        }
    }
    
    func deleteContact(_ index: IndexPath) {
        contactsRepository?.deleteContact(type: "contact", id: entities[index.row].id) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.entities.remove(at: index.row)
            strongSelf.shouldReloadTable.value = true
            strongSelf.shouldShowLoading.value = false
        }
        UserDefaultRepository.removeFromRecent(entities[index.row], completion: nil)
    }
}


// MARK: BaseDataSource methods
extension ContactsViewModel: BaseDataSource {
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return entities.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        let cellModel = entities[index]
        if index == entities.count - 1, nextPageURL != nil {
            configurator = LoadingCellConfigurator(data: nil)
        } else {
            configurator = ContactCellConfigurator(data: cellModel) {[weak self] in
                guard let strongSelf = self else { return }
                UserDefaultRepository.saveRecentContact(cellModel)
                strongSelf.shouldShowLoading.value = true
                strongSelf.delegate?.showContactsDetail(cellModel.id, showLoading: strongSelf.shouldShowLoading)
            }
        }
        return configurator
    }
}

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
    var entities: Observable<[Contact]> {get}
    var shouldShowLoading: Observable<Bool> {get set}
    var shouldReloadTable: Observable<Bool> {get set}
}

class ContactsViewModel: ContactsViewModelProtocol {
    var shouldShowLoading = Observable<Bool>(false)
    var entities = Observable<[Contact]>()
    var shouldReloadTable = Observable<Bool>(false)
    private var currentItemType: String = "contact"
    private var nextPageURL: String?
    private var contactsRepository: ContactsRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactsCoordinatorDelegate?
    
    init(contactsRepository: ContactsRepositoryProtocol) {
        self.contactsRepository = contactsRepository
        self.contactsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { (itemsResponse) in
            print(itemsResponse ?? "itemsResponse is nil")
            self.entities.value = itemsResponse?.data
            self.nextPageURL = itemsResponse?.links?.nextLink
            print(self.nextPageURL ?? "")
            self.shouldReloadTable.value = true
        }
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return entities.value?.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        guard let item = entities.value?[index] else { return nil }
        let cellModel = Contact(id: item.id,
                                es: item.es,
                                name: item.name)
        configurator = ContactCellConfigurator(data: cellModel) {[weak self] in
            guard let strongSelf = self, let contacts = self?.entities.value else { return }
            strongSelf.shouldShowLoading.value = true
            strongSelf.delegate?.showAllContacts(contacts)
        }
        return configurator
    }
}

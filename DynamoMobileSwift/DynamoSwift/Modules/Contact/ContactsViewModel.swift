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
    //    var shouldShowLoading: Observable<Bool> {get set}
        var shouldReloadTable: Observable<Bool> {get set}
}

class ContactsViewModel: ContactsViewModelProtocol {
    var entities = Observable<[Contact]>()
    var shouldReloadTable = Observable<Bool>(false)
   // var contacts: [Contact]?
    private var currentItemType: String = "contact"
    private var nextPageURL: String?
    private var itemsRepository: ContactsRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactsCoordinatorDelegate?
    
    init() {
        itemsRepository = ContactsRepository()
        itemsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { (itemsResponse) in
            print(itemsResponse?.data ?? "itemsResponse is nil")
            self.entities.value = itemsResponse?.data
            self.shouldReloadTable.value = true
        }
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return entities.value?.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        let cellModel = Contact(id: entities.value?[index].id ?? "", es: entities.value?[index].es ?? "", name: entities.value?[index].name ?? "")
        configurator = ContactCellConfigurator(data: cellModel) {[weak self] in
            guard let strongSelf = self, let contacts = self?.entities.value else { return }
            strongSelf.delegate?.openAllEntities(contacts)
        }
        return configurator
    }
}

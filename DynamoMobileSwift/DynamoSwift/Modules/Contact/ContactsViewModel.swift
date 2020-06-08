//
//  ContactsCellViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage
//
//protocol ContactsViewModelProtocol: BaseDataSource {
//    //var entities: Observable<[Contact]> {get}
//    //    var shouldShowLoading: Observable<Bool> {get set}
//    //    var shouldReloadTable: Observable<Bool> {get set}
//}

class ContactsViewModel: BaseDataSource {
    var contacts: [Contact]?
    private var currentItemType: String = "contact"
    private var nextPageURL: String?
    private var itemsRepository: ContactsRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactsCoordinatorDelegate?
    
    init() {
        itemsRepository = ContactsRepository()
        itemsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { (itemsResponse) in
            print(itemsResponse?.data ?? "itemsResponse is nil")
            self.contacts = itemsResponse?.data
        }
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return contacts?.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        let cellModel = ContactCellModel(id: contacts?[index].id ?? "", es: contacts?[index].es ?? "")
        configurator = ContactCellConfigurator(data: cellModel) {[weak self] in
            guard let strongSelf = self, let contacts = self?.contacts else { return }
            strongSelf.delegate?.openAllEntities(contacts)
        }
        return configurator
    }
}

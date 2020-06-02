//
//  ContactsViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class ContactsViewModel: ContactsViewModelProtocol {
    
    /*************************************/
    // MARK: - Properties
    /*************************************/
//    var entities = Observable<[BaseEntityModel]>()
    private var contactsEntitiesRepository: ContactsEntitiesRepositoryProtocol
    weak var delegate: ContactsCoordinatorDelegate?
    var shouldShowLoading = Observable<Bool>(false)
    var shouldShowNoRecentView = Observable<Bool>(false)
    var documentFileURL = Observable<URL>(nil)
    private var isInitialLoad = true
    /*************************************/
    // MARK: - ViewModel
    /*************************************/
    
    init(contactsEntitiesRepository: ContactsEntitiesRepositoryProtocol = ContactsEntitiesRepository()) {
        self.contactsEntitiesRepository = contactsEntitiesRepository
        documentFileURL.bind {[weak self] (url) in
            guard let strongSelf = self else { return }
            strongSelf.shouldShowLoading.value = false
        }
    }
}

// MARK: - CoordinatableViewModel
extension ContactsViewModel: CoordinatableViewModel {
    /*************************************/
    // MARK: - implement start() if needed
    /*************************************/
}

// MARK: - BaseDataSource
extension ContactsViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return 0 //entities.value?.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        let currentItem: BaseEntityModel
        
//        guard index >= 0, index < entities.value?.count ?? 0,
//            let entities = entities.value else { return nil }
//
        currentItem = PickerItem()

//
        let detailAction = {[weak self] in
            guard let strongSelf = self else { return }

            strongSelf.shouldShowLoading.value = true
            strongSelf.delegate?.openEntityDetail(for: currentItem, showLoading: strongSelf.shouldShowLoading)
        }
//
//        let openDocAction = {[weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.shouldShowLoading.value = true
//            strongSelf.loadDocumentWith(docID: currentItem.id) { _ in
//                strongSelf.shouldShowLoading.value = false
//            }
//        }
//
        let isFolder = (currentItem as? ViewListItem)?.viewData.what?.type == "nop"
        var title = currentItem.identifier ?? currentItem.name ?? ""
        if let entityItem = currentItem as? EntityListItem, title.isEmpty {
            title = entityItem.message ?? ""
        }
        let subtitle = currentItem.subtitle ?? ""
        let cellModel = ContactsCellModel(title: title,
                                             subtitle: subtitle,
                                             shouldCenteringLabels: true,
                                             isFolder: isFolder)//,
                                             //entityData: currentItem)
        configurator = GenericCellConfigurator(data: cellModel) {
            detailAction()
        }
        return configurator
    }
}

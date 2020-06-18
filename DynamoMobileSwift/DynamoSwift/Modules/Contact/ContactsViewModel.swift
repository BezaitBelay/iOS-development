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
    var entities: [Contact] = []
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
                                                guard let strongSelf = self else { return }
                                                strongSelf.entities = itemsResponse?.data ?? []
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
            strongSelf.saveRecentContact(cellModel)
            strongSelf.shouldShowLoading.value = true
            strongSelf.delegate?.showContactsDetail(cellModel.id, showLoading: strongSelf.shouldShowLoading)
        }
        
        return configurator
    }
    
    func requestNextPageWhen(index: Int) {
        guard index == entities.count - 1, nextPageURL != nil else { return }
        shouldShowLoading.value = true
        contactsRepository?.getEntitiesOf(type: currentItemType, nextPageURL: nextPageURL) { [weak self] (itemsResponse) in
            //            print(itemsResponse ?? "itemsResponse is nil")
            guard let strongSelf = self else { return }
            strongSelf.entities.append(contentsOf: itemsResponse?.data ?? [])
            strongSelf.nextPageURL = itemsResponse?.links?.nextLink
            strongSelf.shouldShowLoading.value = false
            strongSelf.shouldReloadTable.value = true
        }
    }
    
    private func saveRecentContact(_ contact: Contact) {
//        UserDefaults.standard.removeObject(forKey: Constants.Storyboards.contacts)
//        let date = Date()
//        let dataFormatter = DateFormatter()
//        dataFormatter.dateStyle = .short
//        dataFormatter.timeStyle = .short
//        let dateString = dataFormatter.string(from: date)
//
       //  let items = UserDefaults.standard.array(forKey: Constants.Storyboards.contacts) //else {
            let info = contact //UserDefaultContact(contact: contact, date: date)
            let encoder = JSONEncoder()
//            encoder.dateEncodingStrategy = .formatted(.dateFormatter)
            let array = [info]
            if let encoded = try? encoder.encode(array) {
                UserDefaults.standard.set(encoded, forKey: Constants.Storyboards.contacts)
                print("added successfully")
            }
            return
        //}
//        guard var savedContacts = existingValue as? [UserDefaultContact] else { return }
//        let info = UserDefaultContact(contact: contact, date: date)
//        savedContacts.append(info)
//        let encoder = JSONEncoder()
////        encoder.dateEncodingStrategy = .formatted(.dateFormatter)
//        if let encoded = try? encoder.encode(savedContacts) {
//            UserDefaults.standard.set(encoded, forKey: "Contacts")
//            print("added successfully")
//        }
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
}

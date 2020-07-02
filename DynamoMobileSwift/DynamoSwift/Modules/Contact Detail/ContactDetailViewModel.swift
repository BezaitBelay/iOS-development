//
//  ContactDetailViewModel.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ContactDetailViewModelProtocol: BaseDataSource {
    var fieldItems: [ItemFieldCellModel] { get }
    var shouldReloadTable: Observable<Bool> { get set }
    var editButtonTapped: Bool { get set }
    var shouldShowLoading: Observable<Bool> { get set}
    func updateItem(completion: @escaping () -> Void)
}

class ContactDetailViewModel: ContactDetailViewModelProtocol {
    var editButtonTapped = false
    var shouldShowLoading = Observable<Bool>(false)
    var shouldReloadTable = Observable<Bool>(false)
    
    var fieldItems: [ItemFieldCellModel] = []
    var rawData: [String: String] = [:]
    var numberOfSections: Int = 1
    weak var delegate: ContactDetailCoordinatorDelegate?
    private var contactDetailRepository: ContactDetailRepositoryProtocol?
    
    init(contactDetailRepository: ContactDetailRepositoryProtocol, id: String) {
        self.contactDetailRepository = contactDetailRepository
        shouldShowLoading.value = true
        self.contactDetailRepository?.getEntityDataFor(id, itemType: "contact") { [weak self] (itemsResponse) in
            //print(itemsResponse ?? "item detail Response is nil")
            guard let strongSelf = self else { return }
            strongSelf.rawData = itemsResponse?.data ?? [:]
            strongSelf.transformData(strongSelf.rawData)
            strongSelf.shouldReloadTable.value = true
            strongSelf.shouldShowLoading.value = false
        }
    }
    
    func updateItem(completion: @escaping () -> Void) {
        let idProperty = rawData.first(where: { item -> Bool in return item.key == "_id" })
        var properties: [String: String] = [:]
        for item in fieldItems {
            guard let updatedItem = item.newValue.value, let index = item.propertyName else { continue }
            properties[index] = updatedItem
        }
        contactDetailRepository?.postEntityDataFor(idProperty?.value ?? "", itemType: "contact", properties: properties) { [weak self] (itemsResponse) in
            guard let strongSelf = self else { return }
            strongSelf.rawData = itemsResponse?.data ?? [:]
            strongSelf.transformData(strongSelf.rawData)
            strongSelf.shouldShowLoading.value = false
            strongSelf.shouldReloadTable.value = true
            completion()
        }
    }
    
    //MARK: Private methods
    private func transformData(_ rawData: [String: String]) {
        fieldItems = []
        for field in rawData {
            guard field.key != "_id", field.key != "_es" else { continue }
            let model = ContactDetailSorting.init(rawValue: field.key.lowercased())
            let fieldModel = ItemField(label: model?.label ?? "",
                                       value: field.value,
                                       position: model?.position ?? 0,
                                       isEditing: editButtonTapped)
            fieldItems.append(fieldModel)
        }
        fieldItems = fieldItems.sorted { $0.propertyPosition < $1.propertyPosition }
    }
    
}

// MARK: BaseDataSource extension
extension ContactDetailViewModel: BaseDataSource {
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return fieldItems.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        var cellModel = fieldItems[index]
        cellModel.isEditing = editButtonTapped
        
        switch cellModel.propertyPosition {
        case 0, 2, 3: configurator = ContactDetailCellConfigurator(data: cellModel, didSelectAction: nil)
        case 1, 4, 6: configurator = ContactDetailWithActionCellConfigurator(data: cellModel) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.configureAction(for: cellModel)
            }
        default: configurator = ContactDetailCommentCellConfigurator(data: cellModel, didSelectAction: nil)
        }
        return configurator
    }
    
    //MARK: Private methods
    private func configureAction(for cellModel: ItemFieldCellModel) {
        guard editButtonTapped == false else { return }
           if cellModel.propertyName == ContactDetailSorting.primarycontactemail.label {
               delegate?.openMailComposeViewController(propertyValue: cellModel.propertyValue)
           } else if cellModel.propertyName == ContactDetailSorting.primarycontactphone.label {
               makeCallWith(cellModel.propertyValue ?? "")
           } else {
               openURL(cellModel.propertyValue ?? "")
           }
       }
       
       private func makeCallWith(_ phoneNumber: String  ) {
           let number = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
           guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else { return }
           UIApplication.shared.open(url, options: [:], completionHandler: nil)
       }
       
       private func openURL(_ url: String) {
           guard let url = url.webUrlAddressFromString  else { return }
           UIApplication.shared.open(url)
       }
}

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
    var editButtonTapped: Observable<Bool> { get set }
}

class ContactDetailViewModel: ContactDetailViewModelProtocol {
    var editButtonTapped = Observable<Bool>(false)
    var shouldReloadTable = Observable<Bool>(false)
    var fieldItems = [ItemFieldCellModel]()
    private var contactDetailRepository: ContactDetailRepositoryProtocol?
    var numberOfSections: Int = 1
    weak var delegate: ContactDetailCoordinatorDelegate?
    
    init(contactDetailRepository: ContactDetailRepositoryProtocol, id: String) {
        self.contactDetailRepository = contactDetailRepository
        self.contactDetailRepository?.getEntityDataFor(id, itemType: "contact") { [weak self] (itemsResponse) in
            print(itemsResponse ?? "item detail Response is nil")
            guard let strongSelf = self else { return }
            let fieldData = itemsResponse?.data ?? [:]
            var fieldItems: [ItemFieldCellModel] = []
            for field in fieldData {
                guard field.key != "_id", field.key != "_es" else { continue }
                let model = ContactDetailSorting.init(rawValue: field.key.lowercased())
                let fieldModel: ItemFieldCellModel
                //                if field.key == "Primarycontactemail" {
                //                    fieldModel = MailField(key: model?.label ?? "",
                //                                           value: field.value,
                //                                           position: model?.position ?? 0,
                //                                           isEditing: strongSelf.editButtonTapped.value ?? false)
                //                } else {
                fieldModel = ItemField(key: model?.label ?? "",
                                       value: field.value,
                                       position: model?.position ?? 0,
                                       isEditing: strongSelf.editButtonTapped.value ?? false)
                //                }
                fieldItems.append(fieldModel)
            }
            strongSelf.fieldItems = fieldItems.sorted { $0.propertyPosition < $1.propertyPosition }
            strongSelf.shouldReloadTable.value = true
        }
    }
    
    func numberOfCellsInSection(_ section: Int) -> Int? {
        return fieldItems.count
    }
    
    func viewConfigurator(at index: Int, in section: Int) -> ViewConfigurator? {
        let configurator: ViewConfigurator
        var cellModel = fieldItems[index]
        cellModel.isEditing = editButtonTapped.value ?? false
        switch cellModel.propertyPosition {
        case 0, 2, 3: configurator = ContactDetailCellConfigurator(data: cellModel, didSelectAction: nil)
        case 1, 4, 6: configurator = ContactDetailWithActionCellConfigurator(data: cellModel) { [weak self] in
            guard let strongSelf = self else { return }
            if !(strongSelf.editButtonTapped.value ?? true) {
                if cellModel.propertyName == ContactDetailSorting.primarycontactemail.label {
                    strongSelf.delegate?.openMailComposeViewController(propertyValue: cellModel.propertyValue)
                } else if cellModel.propertyName == ContactDetailSorting.primarycontactphone.label {
                    let number = (cellModel.propertyValue ?? "").components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    guard let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) else { return }
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    guard let url = URL(string: cellModel.propertyValue ?? "") else { return }
                    UIApplication.shared.open(url)
                }}
            }
        default: configurator = ContactDetailCommentCellConfigurator(data: cellModel, didSelectAction: nil)
        }
        return configurator
    }
    
}

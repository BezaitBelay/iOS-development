//
//  ContactDetailVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class ContactDetailVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var originalInsetBottom: CGFloat = 0
    
    var viewModel: ContactDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem  = editButton
        tableView.register(cellNames: "\(ContactDetailTableViewCell.self)",
            "\(ContactDetailWithActionTableViewCell.self)",
            "\(ContactDetailCommentTableViewCell.self)")
        
        bindViewModel(viewModel)
        tableView.keyboardDismissMode = .onDrag
        registerForKeyboardNotifications()
        tableView.tableFooterView = UIView()
    }
    
    @objc func editButtonTapped() {
        if let title = navigationItem.rightBarButtonItem?.title, title == "Edit" {
            navigationItem.rightBarButtonItem?.title = "Save"
            changeShowRowMode()
        } else {
            let count = tableView.numberOfRows(inSection: 0)
            var properties: [String: String] = [:]
            for index in 0...count {
                let indexPath = IndexPath(row: index, section: 0)
                guard let property = tableView.cellForRow(at: indexPath) as? CellDataProtocol,
                    property.populateData().keys.first != ContactDetailSorting.companyName.label else { continue }
                properties[property.populateData().keys.first ?? ""] = property.populateData().values.first ?? ""
            }
//            viewModel?.shouldShowLoading.value = true
//            viewModel?.updateItem(properties)
            navigationItem.rightBarButtonItem?.title = "Edit"
            changeShowRowMode()
        }
    }
    
    // MARK: Private methods
    private func bindViewModel(_ viewModel: ContactDetailViewModelProtocol?) {
        viewModel?.shouldReloadTable.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel?.editButtonTapped.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel?.shouldShowLoading.bindAndFire { [weak self] (start) in
            guard let strongSelf = self else { return }
            if start {
                strongSelf.startLoading()
            } else {
                strongSelf.stopLoading()
            }
        }
    }
    
    private func changeShowRowMode() {
        viewModel?.editButtonTapped.value = !(viewModel?.editButtonTapped.value ?? false)
        if let separatorValue = viewModel?.editButtonTapped.value {
            tableView.separatorStyle =  separatorValue ? .none : .singleLine
        }
    }
    
}

// MARK: UITableViewDataSource methods
extension ContactDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else {
            return UITableViewCell()
        }
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCellsInSection(section) ?? 0
    }
}

extension ContactDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section)?.didSelectAction?()
    }
}

// MARK: - StoryboardInstantiatable
extension ContactDetailVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

// MARK: - Keyboard Notifications
extension ContactDetailVC: KeyboardОbserversHandler {
    func keyboardWillShowAction(notification: NSNotification) {
        let userInfo = notification.userInfo
        guard let kbRect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect),
            let rootView = self.view.window?.rootViewController?.view
            else { return }
        
        let newKbSize = view.window?.convert(kbRect, to: rootView).size ?? .zero
        
        let contentInsets = UIEdgeInsets(top: tableView.contentInset.top,
                                         left: 0.0,
                                         bottom: originalInsetBottom + newKbSize.height,
                                         right: tableView.contentInset.right)
        
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    func keyboardWillHideAction() {
        let contentInsets = UIEdgeInsets(top: tableView.contentInset.top,
                                         left: 0.0,
                                         bottom: originalInsetBottom,
                                         right: tableView.contentInset.right)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
}

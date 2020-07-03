//
//  ContactsVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class ContactsVC: BaseVC {
    
    /*************************************/
    // MARK: - Properties
    /*************************************/
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ContactsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.contacts
        tableView.register(cellNames: "\(ContactsTableViewCell.self)", "\(LoadingTableViewCell.self)")
        bindViewModel(viewModel)
    }
    
    // MARK: Private methods
    private func bindViewModel(_ viewModel: ContactsViewModelProtocol?) {
        viewModel?.shouldReloadTable.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel?.shouldHideTable.bindAndFire { [weak self] (start) in
            guard let strongSelf = self else { return }
            strongSelf.tableView.isHidden = start
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
}

// MARK: UITableViewDataSource methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        
        viewModel?.requestNextPageWhen(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCellsInSection(section) ?? 0
    }
}

// MARK: UITableViewDelegate methods
extension ContactsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section)?.didSelectAction?()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.shouldShowLoading.value = true
            viewModel?.deleteContact(indexPath)
        }
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

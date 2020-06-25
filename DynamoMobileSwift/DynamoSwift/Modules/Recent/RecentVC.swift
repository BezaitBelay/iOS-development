//
//  RecentVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class RecentVC: BaseVC {
    
    /*************************************/
    // MARK: - Properties
    /*************************************/
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [Contact]?
    var viewModel: RecentViewModel?
    
    override var isVisible: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.recent
        tableView.register(cellNames: "\(ContactsTableViewCell.self)")
        bindViewModel(viewModel)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.entities = UserDefaultRepository.getContacts(of: Contact.self, for: Constants.Storyboards.contacts) ?? []
        viewModel?.shouldReloadTable.value = true
    }
    
    // MARK: Private methods
    private func bindViewModel(_ viewModel: RecentViewModel?) {
        viewModel?.shouldReloadTable.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        viewModel?.shouldShowLoading.bindAndFire { [weak self] (start) in
            guard let strongSelf = self else { return }
            if start {
                strongSelf.startLoading()
                strongSelf.tableView.isHidden = true
            } else {
                strongSelf.stopLoading()
                strongSelf.tableView.isHidden = false
            }
        }
        
    }
}

// MARK: UITableViewDataSource methods
extension RecentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfCellsInSection(section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension RecentVC: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
      return "Remove from Recent"
    }
}

// MARK: - StoryboardInstantiatable
extension RecentVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.recent
    }
}

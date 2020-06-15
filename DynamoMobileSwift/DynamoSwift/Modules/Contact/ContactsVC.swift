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
        tableView.register(cellNames: "\(ContactsTableViewCell.self)")
        bindViewModel(viewModel)
    }
    
    // MARK: Private methods
    private func bindViewModel(_ viewModel: ContactsViewModelProtocol?) {
        viewModel?.shouldReloadTable.bindAndFire { [weak self] _ in
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
        print(viewModel?.numberOfCellsInSection(section) ?? 0)
        return viewModel?.numberOfCellsInSection(section) ?? 0
    }
}

extension ContactsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section)?.didSelectAction?()
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

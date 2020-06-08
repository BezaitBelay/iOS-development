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
    
    private func bindViewModel(_ viewModel: ContactsViewModelProtocol?) {
        viewModel?.entities.bindAndFire { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else { return UITableViewCell() }
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        
        configurator.configure(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.numberOfCellsInSection(section) ?? 0)
        return viewModel?.numberOfCellsInSection(section) ?? 0
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

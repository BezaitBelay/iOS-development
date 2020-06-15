//
//  ContactDetailVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class ContactDetailVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    @objc func editButtonTapped() {
        if let title = navigationItem.rightBarButtonItem?.title {
            navigationItem.rightBarButtonItem?.title = title == "Save" ? "Edit" : "Save"
        }
        viewModel?.editButtonTapped.value = !(viewModel?.editButtonTapped.value ?? false)
        if let separatorValue = viewModel?.editButtonTapped.value {
            tableView.separatorStyle =  separatorValue ? .none : .singleLine
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
    }
}

// MARK: - StoryboardInstantiatable
extension ContactDetailVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

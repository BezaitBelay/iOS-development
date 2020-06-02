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
    private var noRecentLabel: UILabel?
    
    override var isVisible: Bool {
        return true
    }
    
    var viewModel: ContactsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.contacts
        tableView.register(cellNames: "\(ContactsTableViewCell.self)")
        
        bindViewModel(viewModel)
    }
    
    private func bindViewModel(_ viewModel: ContactsViewModelProtocol?) {
        viewModel?.shouldShowLoading.bindAndFire {[weak self] (start) in
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5//viewModel?.numberOfCellsInSection(section) ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.configureCell(for: configurator, at: indexPath)
        return cell
    }
}

// MARK: UITableViewDelegate methods
extension ContactsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section)?.didSelectAction?()
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove from recents"
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

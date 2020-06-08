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
    }
}

// MARK: UITableViewDataSource methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let configurator = viewModel?.viewConfigurator(at: indexPath.row, in: indexPath.section) else { return UITableViewCell() }
        guard let contacts = viewModel?.contacts else { return UITableViewCell()}
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath)
            as? ContactsTableViewCell else { return UITableViewCell() }
        
        let cellViewModel = ContactCellModel(id: contacts[indexPath.row].id, es: contacts[indexPath.row].es)
        configurator.configure(cell)
        cell.configureWith(cellViewModel)
        
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

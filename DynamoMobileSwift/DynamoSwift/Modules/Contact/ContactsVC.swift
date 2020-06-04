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
    var cellViewModels = [ContactsCellViewModel]()
    
    let apiClient = ApiClient()
    override var isVisible: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.contacts
        tableView.register(cellNames: "\(ContactsTableViewCell.self)")
        loadContacts()
    }
    
    private func loadContacts() {
        let endpoint = EntityEndpoint.contact(es: "contact")
        apiClient.contacts(with: endpoint) { (either) in
            switch either {
            case .value(let response):
                print(response)
                self.cellViewModels = response.data.map {
                    ContactsCellViewModel(id: $0.id, es: $0.es, url: URL(fileURLWithPath: ""))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
}

// MARK: UITableViewDataSource methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as? ContactsTableViewCell else { return UITableViewCell() }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configureWith(cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

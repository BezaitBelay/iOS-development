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
    let apiClient = ApiClient()
    var data: EntityData?
    override var isVisible: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.contacts
        loadContacts()
    }
    
    private func loadContacts() {
        let endpoint = EntityEndpoint.contact(es: "contact")
        apiClient.contacts(with: endpoint) { (either) in
            switch either {
            case .value(let response):
                print(response)
                self.data = response
            case .error(let error):
                print(error)
            }
        }
    }
}

// MARK: UITableViewDataSource methods
extension ContactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

// MARK: - StoryboardInstantiatable
extension ContactsVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

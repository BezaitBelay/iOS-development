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
    
    var viewModel: RecentsViewModel?
    
    override var isVisible: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.Storyboards.recent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(UserDefaults.standard.dictionaryRepresentation().keys)
        if let item = UserDefaults.standard.array(forKey: Constants.Storyboards.contacts) as? [Contact] {
            print(item)
        }
    }
}

// MARK: UITableViewDataSource methods
extension RecentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - StoryboardInstantiatable
extension RecentVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.recent
    }
}

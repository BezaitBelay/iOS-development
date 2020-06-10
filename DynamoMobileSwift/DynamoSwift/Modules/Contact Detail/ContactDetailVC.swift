//
//  ContactDetailVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 10.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ContactDetailViewModelProtocol: BaseDataSource {
    var shouldShowLoading: Observable<Bool> {get set}
}

class ContactDetailVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ContactDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        bindViewModel(viewModel)
    }
    
    // MARK: Private methods
        private func bindViewModel(_ viewModel: ContactDetailViewModelProtocol?) {
//            viewModel?.reloadTableAtSection.bind {[weak self] section in
//                guard let strongSelf = self, let section = section, strongSelf.isVisible else { return }
//                print("Reload section", section, strongSelf.isVisible)
//                strongSelf.tableView.reloadData()
//                strongSelf.reloadTableSection(section)
//            }
        }
}

// MARK: - StoryboardInstantiatable
extension ContactDetailVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.contacts
    }
}

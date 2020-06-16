//
//  ContactDetailCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 15.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class ContactDetailCoordinator: Coordinator {
    
    /*************************************/
    // MARK: - Coordinator
    /*************************************/
    
    init(navVC: BaseNavigationVC? = nil, contactId: String) {
        guard let contactDetailVC = ContactDetailVC.instantiateFromStoryboard() as? ContactDetailVC else { return }
        contactDetailVC.shouldFinishScene = true
        let contactDetailViewModel = ContactDetailViewModel(contactDetailRepository: ContactDetailRepository(), id: contactId)
        contactDetailVC.viewModel = contactDetailViewModel
        navVC?.pushViewController(contactDetailVC, animated: true)
    }
    
    override func start() {
        childCoordinators.first?.start()
    }
    
    override func finish() {
        // Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
        removeChildCoordinator(self)
    }
}

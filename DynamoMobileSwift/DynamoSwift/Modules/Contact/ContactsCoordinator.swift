//
//  ContactsCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

protocol ContactsCoordinatorDelegate: class {
    func showContactsDetail(_ contactId: String, showLoading: Observable<Bool>?)
//    func finishCoordination()
}

class ContactsCoordinator: TabCoordinator {
    
    let contactsRepository = ContactsRepository()
    
    /*************************************/
    // MARK: - Coordinator
    /*************************************/
    override var tabIndex: Int {
        return TabBarItem.contact.index
    }
    
    override init() {
        super.init()
        guard let topVC = ContactsVC.instantiateFromStoryboard() as? ContactsVC else { return }
        topVC.shouldFinishScene = true
        rootViewController = BaseNavigationVC(rootViewController: topVC)
        topVC.viewModel = ContactsViewModel(contactsRepository: contactsRepository)
        topVC.viewModel?.delegate = self
        setupTabBar()
    }
    
    override func start() {
        rootViewController?.popToRootViewController(animated: false)
        finishChildCoordinators()
    }
    
    override func finish() {
        // Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
    }
    
    // MARK: Private methods
    private func setupTabBar() {
        rootViewController?.tabBarItem = UITabBarItem(title: TabBarItem.recent.tabBarTitle,
                                                      image: UIImage(named: "ic_contact_on"),
                                                      selectedImage: UIImage(named: "ic_contact_off"))
        rootViewController?.tabBarItem.tag = tabIndex
    }
    
}

extension ContactsCoordinator: ContactsCoordinatorDelegate {
    func showContactsDetail(_ contactId: String, showLoading: Observable<Bool>?) {
        let contactDetailCoordinator = ContactDetailCoordinator(navVC: rootViewController, contactId: contactId)
        addChildCoordinator(contactDetailCoordinator)
        showLoading?.value = false
    }
}

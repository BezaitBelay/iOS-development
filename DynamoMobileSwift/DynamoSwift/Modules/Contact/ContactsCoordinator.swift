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
    //    func showAllContacts(_ entities: [Contact])
    func showContactsDetail(_ contact: Contact) // openEntityDetail
}

class ContactsCoordinator: TabCoordinator {
    
    /*************************************/
    // MARK: - Coordinator
    /*************************************/
    override var tabIndex: Int {
        return TabBarItem.contact.index
    }
    
    let contactsRepository = ContactsRepository()
    
    override init() {
        super.init()
        guard let topVC = ContactsVC.instantiateFromStoryboard() as? ContactsVC else {return}
        topVC.shouldFinishScene = true
        rootViewController = BaseNavigationVC(rootViewController: topVC)
        topVC.viewModel = ContactsViewModel(contactsRepository: contactsRepository)
        topVC.viewModel?.delegate = self
        setupTabBar()
        guard let appCoordinator = UIApplication.mainDelegate?.appCoordinator else { return }
        appCoordinator.openMainTabsNavigation()
        
    }
    
    override func start() {
        rootViewController?.popToRootViewController(animated: false)
    }
    
    override func finish() {
        // Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
        removeChildCoordinator(self)
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
    
    //    func showAllContacts(_ entities: [Contact]) {
    //        guard let contactsVC = ContactsVC.instantiateFromStoryboard() as? ContactsVC else { return }
    //        let contactsViewModel = ContactsViewModel(contactsRepository: contactsRepository)
    //        contactsViewModel.delegate = self
    //        contactsVC.viewModel = contactsViewModel
    //        rootViewController?.pushViewController(contactsVC, animated: true)
    //    }
    
    func showContactsDetail(_ contact: Contact) {
        guard let contactDetailVC = ContactDetailVC.instantiateFromStoryboard() as? ContactDetailVC else { return }
        //        let contactsViewModel = ContactsViewModel(contactsRepository: contactsRepository)
        //        contactsViewModel.delegate = self
        //        contactsVC.viewModel = contactsViewModel
        rootViewController?.pushViewController(contactDetailVC, animated: true)
    }
}

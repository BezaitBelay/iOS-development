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
    func showContactsDetail(_ contact: Contact, showLoading: Observable<Bool>?, contactId: String) // openEntityDetail
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

    func showContactsDetail(_ contact: Contact, showLoading: Observable<Bool>?, contactId: String) {
        guard let contactDetailVC = ContactDetailVC.instantiateFromStoryboard() as? ContactDetailVC else { return }
        let contactDetailViewModel = ContactDetailViewModel(contactDetailRepository: ContactDetailRepository(), id: contactId)
//        contactDetailViewModel.delegate = self
        contactDetailVC.viewModel = contactDetailViewModel
        rootViewController?.pushViewController(contactDetailVC, animated: true)
        showLoading?.value = false
    }
}

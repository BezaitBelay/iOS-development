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
    func openAllEntities(_ entities: [Contact])
}

class ContactsCoordinator: TabCoordinator, ContactsCoordinatorDelegate {
    
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
        setupTabBar()
        topVC.viewModel = ContactsViewModel()
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
    
    private func setupTabBar() {
        rootViewController?.tabBarItem = UITabBarItem(title: TabBarItem.contact.tabBarTitle,
                                                      image: UIImage(named: "ic_contact_on"),
                                                      selectedImage: UIImage(named: "ic_contact_off"))
        rootViewController?.tabBarItem.tag = tabIndex
    }
    
    func openAllEntities(_ entities: [Contact]) {
        guard let allEntitiesVC = ContactsVC.instantiateFromStoryboard() as? ContactsVC else { return }
        let allEntitiesViewModel = ContactsViewModel()
        allEntitiesViewModel.delegate = self
        allEntitiesVC.viewModel = allEntitiesViewModel
        rootViewController?.pushViewController(allEntitiesVC, animated: true)
    }
}

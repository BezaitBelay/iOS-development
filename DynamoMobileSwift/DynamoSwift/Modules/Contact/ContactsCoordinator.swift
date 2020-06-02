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
    func openEntityDetail(for item: BaseEntityModel, showLoading: Observable<Bool>?)
    // func openDocumentWith(url: URL)
}

class ContactsCoordinator: TabCoordinator {
    
    var viewModelReadyAction: (() -> Void)?
    
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
        let viewModel = ContactsViewModel()
        viewModel.delegate = self
        topVC.viewModel = viewModel
        rootViewController = BaseNavigationVC(rootViewController: topVC)
        setupTabBar()
        
        guard let appCoordinator = UIApplication.mainDelegate?.appCoordinator else { return }
        self.viewModelReadyAction?()
        appCoordinator.openMainTabsNavigation()
        
    }
    
    override func start() {
        rootViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        rootViewController?.popToRootViewController(animated: false)
        // finishChildCoordinators()
    }
    
    override func finish() {
        // Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
    }
    
    private func setupTabBar() {
        rootViewController?.tabBarItem = UITabBarItem(title: TabBarItem.contact.tabBarTitle,
                                                      image: UIImage(named: "ic_contact_on"),
                                                      selectedImage: UIImage(named: "ic_contact_off"))
        rootViewController?.tabBarItem.tag = tabIndex
        setupTabBarTitleColors()
    }
}

// MARK: ContactsCoordinatorDelegate methods
extension ContactsCoordinator: ContactsCoordinatorDelegate {
    func openEntityDetail(for item: BaseEntityModel, showLoading: Observable<Bool>?) {
        let detailsCoordinator = ContactsCoordinator()
        guard let detailVC = detailsCoordinator.rootViewController,
            let rootViewController = rootViewController else {return}
        
        self.addChildCoordinator(detailsCoordinator)
        rootViewController.pushViewController(detailVC, animated: true)
        
    }
}

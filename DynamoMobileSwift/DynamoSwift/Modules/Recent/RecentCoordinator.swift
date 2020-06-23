//
//  RecentCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit
import TwoWayBondage

class RecentCoordinator: TabCoordinator {
    
    /*************************************/
    // MARK: - Coordinator
    /*************************************/
    override var tabIndex: Int {
        return TabBarItem.recent.index
    }
    
    override init() {
        super.init()
        guard let topVC = RecentVC.instantiateFromStoryboard() as? RecentVC else {return}
        topVC.shouldFinishScene = true
        topVC.viewModel = RecentViewModel()
        rootViewController = BaseNavigationVC(rootViewController: topVC)
        setupTabBar()
    }
    
    override func start() {
        rootViewController?.popToRootViewController(animated: false)
    }
    
    override func finish() {
        // Clean up your rootViewController or any data that will persist and remove self from parentCoordinator
//        removeChildCoordinator(self)
        rootViewController?.popToRootViewController(animated: false)
        finishChildCoordinators()
    }
    
    private func setupTabBar() {
        rootViewController?.tabBarItem = UITabBarItem(title: TabBarItem.recent.tabBarTitle,
                                                      image: UIImage(named: "ic_recent_on"),
                                                      selectedImage: UIImage(named: "ic_recent_off"))
        rootViewController?.tabBarItem.tag = tabIndex
       // setupTabBarTitleColors()
    }
}

extension RecentCoordinator: ContactsCoordinatorDelegate {
    func showContactsDetail(_ contactId: String, showLoading: Observable<Bool>?) {
        let contactDetailCoordinator = ContactDetailCoordinator(navVC: rootViewController, contactId: contactId)
        addChildCoordinator(contactDetailCoordinator)
        showLoading?.value = false
    }
    
    func finishCoordination() {
        finish()
    }
}

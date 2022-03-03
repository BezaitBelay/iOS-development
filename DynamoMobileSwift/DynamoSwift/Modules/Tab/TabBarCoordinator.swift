//
//  TabBarCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

/// Exposes AppCoordinator functionality
protocol TabCoordinationDelegate: class {
    // props & funcs which should be handled by the AppCoordinator
}

protocol TabBarCoordinatorProtocol: class {
    func didSelectTab(_ index: Int)
}

class TabBarCoordinator: Coordinator {
    
    var rootViewController: MainTabBarVC!
    fileprivate var previousTabIndex = 0
    weak var delegate: TabCoordinationDelegate?
    
    private func getRootViewController(for storyboardName: String) -> UIViewController? {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }
    
    override init() {
        super.init()
        
        if let tabBarInstantiatedVC = MainTabBarVC.instantiateFromStoryboard() as? MainTabBarVC {
            rootViewController = tabBarInstantiatedVC
            rootViewController?.tabBarCoordinatorDelegate = self
        }
        manageTabCoordinatorsAndControllers()
    }
    
    override func start() {
        childCoordinators.first?.start()
    }
    
    func currentCoordinator() -> TabCoordinator? {
        let tabCoordinator = childCoordinators.first { (coordinator) -> Bool in
            if let coordinator = coordinator as? TabCoordinator {
                return coordinator.tabIndex == previousTabIndex
            }
            return false
        }
        return tabCoordinator as? TabCoordinator
    }
    
    // MARK: Private methods
    private func manageTabCoordinatorsAndControllers() {
        // Store the roots of each coordinator
        var tabCoordinators: [TabCoordinator] = []
        var viewControllers: [UIViewController] = []
        
        let contactsCoordinator = ContactsCoordinator()
        tabCoordinators.append(contactsCoordinator)
        
        let recentCoordinator = RecentCoordinator()
        tabCoordinators.append(recentCoordinator)

        // Sort the local coordinators array
        tabCoordinators.sort { (c1, c2) -> Bool in
            return c1.tabIndex < c2.tabIndex
        }
        
        // for each coordinator add the root and a child coordinator
        for coordinator in tabCoordinators {
            if let rootVC = coordinator.rootViewController {
                viewControllers.append(rootVC)
                addChildCoordinator(coordinator)
            }
        }
        
        rootViewController?.viewControllers = viewControllers
    }
}

// MARK: TabBarCoordinatorProtocol methods
extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func didSelectTab(_ index: Int) {
        guard index != previousTabIndex else { return }
        let tabCoordinator = childCoordinators.first { (coordinator) -> Bool in
            if let coordinator = coordinator as? TabCoordinator {
                return coordinator.tabIndex == index
            }
            return false
        }
        if let tabCoordinator = tabCoordinator as? TabCoordinator {
            print("DidSelectTab: \(index)")
            previousTabIndex = index
            tabCoordinator.start()
        }
    }
}

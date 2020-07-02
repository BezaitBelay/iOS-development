//
//  MainTabBarVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    weak var tabBarCoordinatorDelegate: TabBarCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabBarCoordinatorDelegate?.didSelectTab(item.tag)
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        guard let items = tabBar.items else { return }
        
        items.forEach {$0.title = ""}
    }
}

// MARK: - StoryboardInstantiatable
extension MainTabBarVC: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.Storyboards.main
    }
}

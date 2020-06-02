//
//  TabCoordinator.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

class TabCoordinator: Coordinator {
    
    var rootViewController: BaseNavigationVC?
    
    var tabIndex: Int {
        return 0
    }
    
    override init() {
        super.init()
    }
    
    func setupTabBarTitleColors() {
        rootViewController?.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.5)
            ],
                                                              for: .normal)
        rootViewController?.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.baseBlue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.5)
            ],
                                                              for: .selected)
    }
}

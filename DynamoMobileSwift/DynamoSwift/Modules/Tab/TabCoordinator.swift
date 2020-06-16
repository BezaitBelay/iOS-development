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
}

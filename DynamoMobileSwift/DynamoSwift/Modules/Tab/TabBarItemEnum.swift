//
//  TabBarItemEnum.swift
//  DynamoSwift
//
//  Created by Rumyana Atanasova on 12.11.19.
//  Copyright © 2019 Upnetix. All rights reserved.
//

import Foundation

public enum TabBarItem: Int {
    case contact
    case recent
    
    var index: Int {
        return rawValue
    }
    
    var tabBarTitle: String {
        switch self {
        case .contact:
            return "Contact"
        case .recent:
            return "Recdent"
        }
    }
}

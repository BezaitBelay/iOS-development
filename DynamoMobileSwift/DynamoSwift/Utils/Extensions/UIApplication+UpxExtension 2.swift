//
//  File.swift
//  Skeleton
//
//  Created by Martin Vasilev on 2.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static var mainDelegate: AppDelegate? {
        return shared.delegate as? AppDelegate
    }
}

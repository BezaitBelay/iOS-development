//
//  UrlExtension.swift
//  Skeleton
//
//  Created by Martin Vasilev on 2.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation
import UIKit

extension URL {
    
    func open(withCompletion completion: ((Bool) -> Void)? = nil) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(self, options: [:], completionHandler: completion)
        } else {
            UIApplication.shared.openURL(self)
        }
    }
    
    func canOpen() -> Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}

//
//  StoryboardInstantiatableVCProtocol.swift
//
//  Created by Valentin Kaltchev on 3/7/17.
//  Copyright © 2017 Upnetix, Inc. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardInstantiatable: class {
    
    /* Make sure this protocol is only used by classes inhereting UIViewController */
    // swiftlint:disable:next type_name
    associatedtype vc: UIViewController = Self
    
    /* Returns the name of the storyboard where the view of the ViewController is */
    static func storyboardName() -> String
    
    static func instantiateFromStoryboard(withName storyboardName: String) -> UIViewController
}

//extension won't work in @objc ViewController classes, you will have to implement the method in the ViewController itself.
public extension StoryboardInstantiatable where Self: UIViewController {
    static func instantiateFromStoryboard(withName storyboardName: String = Self.storyboardName()) -> UIViewController {
        return UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: String(describing: self))
    }
}

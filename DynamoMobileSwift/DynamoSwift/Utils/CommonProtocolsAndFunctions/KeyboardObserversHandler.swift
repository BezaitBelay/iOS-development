//
//  KeyboardObserversHandler.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 16.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

typealias KeyboardОbserversHandler = KeyboardAddObserverProtocol & KeyboardSelectorsProtocol
@objc protocol KeyboardSelectorsProtocol: class {
    func keyboardWillShowAction(notification: NSNotification)
    func keyboardWillHideAction()
}

protocol KeyboardAddObserverProtocol: class {
    func registerForKeyboardNotifications()
}

extension KeyboardSelectorsProtocol where Self: UIViewController {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

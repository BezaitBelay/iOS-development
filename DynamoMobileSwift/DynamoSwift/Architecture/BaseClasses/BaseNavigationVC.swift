//
//  BaseNavigationVC.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 29.05.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import UIKit

private enum ScreenOrientation {
    case lockedInPortrait
    case unlocked
}

class BaseNavigationVC: UINavigationController {
    
    private var screenOrientation: ScreenOrientation = .unlocked
    private var shouldHideStatusBar = false
    
    // MARK: ORIENTATION
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return screenOrientation == .lockedInPortrait ? .portrait : .allButUpsideDown
    }
    
    override var shouldAutorotate: Bool {
        return screenOrientation == .unlocked
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    func pushLocked(viewController: UIViewController, animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
        screenOrientation = .lockedInPortrait
        pushViewController(viewController, animated: animated)
    }
    
    func unlockScreenOrientation() {
        screenOrientation = .unlocked
    }
    
    func hideStatusbar(_ hide: Bool) {
        shouldHideStatusBar = hide
        setNeedsStatusBarAppearanceUpdate()
    }
    
//    override func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
//        guard !(presentedViewController is UIAlertController) || (self is LoginNavigationVC) else {
//            return
//        }
//        super.setNavigationBarHidden(hidden, animated: animated)
//    }
}

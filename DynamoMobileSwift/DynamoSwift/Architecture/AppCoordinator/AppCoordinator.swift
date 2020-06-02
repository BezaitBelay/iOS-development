//
//  AppCoordinator.swift
//  Skeleton
//
//  Created by Martin Vasilev on 1.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let window: UIWindow?
    
    // MARK: Coordinator
    init(window: UIWindow?) {
        self.window = window
        super.init()
    }
    
    override func start() {
        // Start the next coordinator in the heirarchy or the current module rootViewModel
        childCoordinators.first?.start()
    }
    
    override func finish() {
        //
    }
    
    // MARK: Scene Management
    
    /// Called when a BaseVC is loaded (ViewDidLoad:)
    ///
    /// - Parameter sceneVC: The BaseVC of the current Scene
    func sceneDidLoad(_ sceneVC: BaseVC) {
        print("ViewDidLoad: \(sceneVC.vcName)")
    }
    
    /// Called when a BaseVC will appear (ViewWillAppear:)
    ///
    /// - Parameter sceneVC: The BaseVC of the current Scene
    func sceneWillAppear(_ sceneVC: BaseVC) {
        print("ViewWillAppear: \(sceneVC.vcName)")
    }
    
    /// Called when a BaseVC will disappear (ViewWillDisappear:)
    ///
    /// - Parameter sceneVC: The BaseVC of the current Scene
    func sceneWillDisappear(_ sceneVC: BaseVC) {
        print("ViewWillDisappear: \(sceneVC.vcName)")
    }
}

//
//  AppCoordinator.swift
//  Skeleton
//
//  Created by Martin Vasilev on 1.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let window: UIWindow?
    private var loadingView: ScreenLoadingView?
    var tabsCoordinator: TabBarCoordinator?
    
    // MARK: Coordinator
    init(window: UIWindow?) {
        self.window = window
        super.init()
        let tabCoordinator = TabBarCoordinator()
        addChildCoordinator(tabCoordinator)
        guard let window = window else { return }
        window.rootViewController = tabCoordinator.rootViewController ?? UIViewController()
        window.makeKeyAndVisible()
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
    
    func openMainTabsNavigation() {
        guard let tabsCoordinator = tabsCoordinator,
            let window = window else { return }
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = 0.35
        window.rootViewController = tabsCoordinator.rootViewController ?? UIViewController()
        window.makeKeyAndVisible()
        window.layer.add(transition, forKey: "transition")
    }
    
    // MARK: Scene loading
    func startScreenLoading() {
        guard let loadingView = loadingView, loadingView.isHidden else {
            return
        }
        window?.layoutIfNeeded()
        window?.bringSubviewToFront(loadingView)
        loadingView.isHidden = false
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            loadingView.alpha = 1
        }
    }
    
    func stopScreenLoading() {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.loadingView?.alpha = 0
            }, completion: {[weak self] (_) in
                self?.loadingView?.isHidden = true
        })
    }
}

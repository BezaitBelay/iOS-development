//
//  BaseVC.swift
//  Skeleton
//
//  Created by Martin Vasilev on 1.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import UIKit

/// Use left/right side menu type by overriding them and providing specific type
/// Make sure to add logic in imageForSideMenuType and titleForSideMenuType
/// Make sure to handle the menuActions in didPressSideMenuType or in custom overriden action
/// - none: Adds no button
enum SideMenuType {
    case none
}

enum PullToRefreshType {
    case defaultWith(color: UIColor?)
    case customWith(view: UIView)
}

class BaseVC: UIViewController {
    
    var vcName: String {
        return String(describing: self.classForCoder)
    }
    
    var leftSideMenuType: SideMenuType {
        return .none
    }
    var rightSideMenuType: SideMenuType {
        return .none
    }
    
    /// Override for custom logic on side menu click
    var leftSideMenuAction: (() -> Void)? {
        return nil
    }
    
    /// Override for custom logic on side menu click
    var rightSideMenuAction: (() -> Void)? {
        return nil
    }
    
    private var pullToRefreshCustomView: UIView?
    
    var isVisible: Bool {
           return isViewLoaded && view.window != nil
       }
    
    var shouldFinishScene: Bool = false
    
    /// Override for custom logic for pull to refresh
    var pullToRefreshAction: (() -> Void)? {
        preconditionFailure("Override pullToRefreshAction if you're using pull to refresh")
    }
    
    /// Use by adding the refresh control and overriding pullToRefreshAction
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()

        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.mainDelegate?.appCoordinator?.sceneDidLoad(self)
        
        // show settings button on the top right if needed
        if leftSideMenuType != .none {
            let leftBarButtonItem = barButtonItemForType(leftSideMenuType, action: #selector(didPressLeftSideMenu))
            navigationItem.leftBarButtonItem = leftBarButtonItem
        }
        if rightSideMenuType != .none {
            let rightBarButtonItem = barButtonItemForType(rightSideMenuType, action: #selector(didPressRightSideMenu))
            navigationItem.rightBarButtonItem = rightBarButtonItem
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.mainDelegate?.appCoordinator?.sceneWillAppear(self)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidEnterBackground), name: .didEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillEnterForeground), name: .willEnterForeground, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.mainDelegate?.appCoordinator?.sceneWillDisappear(self)
        NotificationCenter.default.removeObserver(self, name: .willEnterForeground, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didEnterBackground, object: nil)
    }
    
    /// Override for specific cases
    @objc func handleDidEnterBackground() {}
    
    /// Override for specific cases
    @objc func handleWillEnterForeground() {}
    
    @objc private func didPressLeftSideMenu() {
        if let customAction = leftSideMenuAction {
            customAction()
        } else {
            didPressSideMenuType(leftSideMenuType)
        }
    }
    
    @objc private func didPressRightSideMenu() {
        if let customAction = rightSideMenuAction {
            customAction()
        } else {
            didPressSideMenuType(rightSideMenuType)
        }
    }
    
    @objc private func didPullToRefresh() {
        guard let refreshControlScroll = refreshControl.superview as? UIScrollView else { return }
        if refreshControlScroll.panGestureRecognizer.state == .changed {
            // The user hasn't lifted his finger yet
            delay(0.1) { [weak self] in
                self?.didPullToRefresh()
            }
        } else {
            // Only start the actual refresh when the pan gesture is in state ended/canceled
            pullToRefreshAction?()
            
        }
    }
    
    // MARK: Loading
    func startLoading() {
//        guard isVisible else { return }
        
        view.endEditing(true)
        UIApplication.mainDelegate?.appCoordinator?.startScreenLoading()
    }
    
    func stopLoading() {
//        guard isVisible else { return }
        
        UIApplication.mainDelegate?.appCoordinator?.stopScreenLoading()
    }
    
    /// You can set a custom refresh control type. Either just a tint color of the default one
    /// or some custom view with custom animation logic.
    /// Important! -> make sure to call this BEFORE any pull to refresh happens if you want the changes to
    /// be preloaded when it does. pullToRefreshAction is NOT the place for this..
    /// - Parameter pullToRefreshType: The type that you want to set
    func setRefreshControl(with pullToRefreshType: PullToRefreshType) {
        pullToRefreshCustomView?.removeFromSuperview()
        switch pullToRefreshType {
        case .defaultWith(let color):
            refreshControl.tintColor = color
        case .customWith(let customView):
            customView.frame = refreshControl.bounds
            customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            customView.contentMode = .scaleAspectFit
            refreshControl.tintColor = .clear
            refreshControl.addSubview(customView)
            pullToRefreshCustomView = customView
        }
    }
    
    private func didPressSideMenuType(_ type: SideMenuType) {
        switch type {
        default:
            print("Left side menu default action triggered")
        }
    }
    
    private func barButtonItemForType(_ type: SideMenuType, action: Selector?) -> UIBarButtonItem? {
        let style = styleForSideMenuType(type)
        // check for image or title
        if let image = imageForSideMenuType(type) {
            return UIBarButtonItem(image: image, style: style, target: self, action: action)
        } else if let title = titleForSideMenuType(type) {
            return UIBarButtonItem(title: title, style: style, target: self, action: action)
        } else {
            return nil
        }
    }
    
    /// Add here images for side menu button items that require images
    ///
    /// - Parameter type: The side menu type enum
    /// - Returns: the UIImage for that type
    private func imageForSideMenuType(_ type: SideMenuType) -> UIImage? {
        switch type {
        default:
            return nil
        }
    }
    
    /// Add here titles for side menu button items that require titles
    ///
    /// - Parameter type: The side menu type enum
    /// - Returns: the title for that type
    private func titleForSideMenuType(_ type: SideMenuType) -> String? {
        switch type {
        default:
            return nil
        }
    }
    
    private func styleForSideMenuType(_ type: SideMenuType) -> UIBarButtonItem.Style {
        // Leaving for future use if there needs to be a new style added
        return .plain
    }
}

//
//  UIActivityIndicator+ViewInCenter.swift
//  MLiTP
//
//  Created by Plamen Penchev on 25.10.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    static func activityIndicatorInCenter(for view: UIView, color: UIColor) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        activityIndicator.frame = view.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        let xCenterConstraint = NSLayoutConstraint(item: view,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1,
                                                   constant: 0)
        view.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: view,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1,
                                                   constant: 0)
        view.addConstraint(yCenterConstraint)
        
        activityIndicator.startAnimating()
        return activityIndicator
    }
}

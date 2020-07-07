//
//  UIViewExtension.swift
//  Skeleton
//
//  Created by Martin Vasilev on 2.08.18.
//  Copyright © 2018 Upnetix. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}

extension UIView {
    func makeBorderInside() {
        frame.insetBy(dx: -borderWidth, dy: -borderWidth)
    }
}

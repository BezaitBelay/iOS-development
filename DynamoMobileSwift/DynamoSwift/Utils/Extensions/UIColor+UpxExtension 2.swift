//
//  UIColorExtension.swift
//  mobile
//
//  Created by martin.vasilev on 6/27/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Is color Ligh or Dark
extension UIColor {
    
    private var luminance: CGFloat {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        func lumHelper(coef: CGFloat) -> CGFloat {
            return (coef < 0.03928) ? (coef/12.92): pow((coef+0.055)/1.055, 2.4)
        }
        
        return 0.2126 * lumHelper(coef: red) + 0.7152 * lumHelper(coef: green) + 0.0722 * lumHelper(coef: blue)
    }
    
    var isDark: Bool {
        return self.luminance < 0.5
    }
}

// MARK: - Hex, String to Color
extension UIColor {
    public convenience init?(hexString: String) {
        let red, green, blue, alpha: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            var hexColor = hexString[start...]
            
            // Handles hexes without alpha
            if hexColor.count == 6 {
                hexColor.append(contentsOf: "FF")
            }
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: String(hexColor))
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    alpha = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: red, green: green, blue: blue, alpha: alpha)
                    return
                }
            }
        }
        
        return nil
    }
    static func color(_ colorName: String) -> UIColor {
        return UIColor(named: colorName) ?? UIColor()
    }
    static let baseBlue = color("Base Blue")
    
}

extension UIColor {
    
    func blendAlpha(coverColor: UIColor) -> UIColor {
        let c1 = coverColor.rgbaTuple()
        let c2 = self.rgbaTuple()
        
        let c1r = CGFloat(c1.r)
        let c1g = CGFloat(c1.g)
        let c1b = CGFloat(c1.b)
        
        let c2r = CGFloat(c2.r)
        let c2g = CGFloat(c2.g)
        let c2b = CGFloat(c2.b)
        
        let red = c1r * c1.a + c2r  * (1 - c1.a)
        let green = c1g * c1.a + c2g  * (1 - c1.a)
        let blue = c1b * c1.a + c2b  * (1 - c1.a)
        
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    func blendMultiply(coverColor: UIColor, alpha: CGFloat = 1.0) -> UIColor {
        return blendProcedure(coverColor: coverColor, alpha: alpha) { return $0 * $1 }
    }
    
    private func blendProcedure(
        coverColor: UIColor,
        alpha: CGFloat,
        procedureBlock: ((_ baseValue: CGFloat, _ topValue: CGFloat) -> CGFloat)?
        ) -> UIColor {
        let baseCompoment = self.rgbaTuple()
        let topCompoment = coverColor.rgbaTuple()
        
        // Mix alpha between the two colors
        let mixAlpha = alpha * topCompoment.a + (1.0 - alpha) * baseCompoment.a
        
        // Mix RGB Values
        let mixR = procedureBlock?(
            baseCompoment.r / 255.0,
            topCompoment.r / 255.0)
            ?? (baseCompoment.r) / 255.0
        
        let mixG = procedureBlock?(
            baseCompoment.g / 255.0,
            topCompoment.g / 255.0)
            ?? (baseCompoment.g) / 255.0
        
        let mixB = procedureBlock?(
            baseCompoment.b / 255.0,
            topCompoment.b / 255.0)
            ?? baseCompoment.b / 255.0
        
        return UIColor.init(red: fitIn(mixR),
                            green: fitIn(mixG),
                            blue: fitIn(mixB),
                            alpha: mixAlpha)
    }
    
    private func fitIn(_ value: CGFloat, ceil: CGFloat = 255) -> CGFloat { return max(min(value, ceil), 0) }
    private func fitIn(_ value: Double, ceil: CGFloat = 255) -> CGFloat { return fitIn(CGFloat(value), ceil: ceil) }
    
    // swiftlint:disable:next large_tuple
    private func rgbaTuple() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red *= 255
        green *= 255
        blue *= 255
        
        return ((red), (green), (blue), alpha)
    }
}

extension UIView {
    
    /**
     Pin the current view's sides to another view.
     @params: toView - the view to be pinned to
     @params: margin - the desired margin. 0 by default
     @params: attributes: the sides to which you want to pin the view
     */
    @discardableResult
    func pinTo(toView: UIView?, margin: CGFloat = 0, attributes: NSLayoutConstraint.Attribute...) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        toView?.translatesAutoresizingMaskIntoConstraints = false
        for side in attributes {
            let constraint = NSLayoutConstraint(item: self,
                                                attribute: side,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: toView,
                                                attribute: side,
                                                multiplier: 1.0,
                                                constant: margin)
            constraints.append(constraint)
        }
        self.addConstraints(constraints)
        return constraints
    }
}

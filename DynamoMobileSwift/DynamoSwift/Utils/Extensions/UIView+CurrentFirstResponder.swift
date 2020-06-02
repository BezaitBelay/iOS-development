import UIKit

extension UIView {
    /// Recursively searchs for firstResponder in view and its' subviews.
    var currentFirstResponder: UIView? {
        if isFirstResponder {
            return self
        }
        
        for view in subviews {
            if let firstResponder = view.currentFirstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    /// Returns the `resignFirstResponder` value of the `currentFirstResponder` or
    /// returns nil if there is no currentFirstResponder.
    @discardableResult
    func resignCurrentFirstResponder() -> Bool? {
        return currentFirstResponder?.resignFirstResponder()
    }
}

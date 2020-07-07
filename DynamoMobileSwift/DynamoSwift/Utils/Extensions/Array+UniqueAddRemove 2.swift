//
//  ArrayExtension.swift
//  mobile
//
//  Created by martin.vasilev on 7/10/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func appendUnique(_ data: Element?) {

        if let data = data {
            // The data exists
            if let index = self.index(of: data) {
                // Overwrite
                self[index] = data
            } else {
                // Append
                self.append(data)
            }
        }
    }
    
    mutating func removeUnique(_ data: Element?) {

        if let data = data {
            // The data exists
            if let index = self.index(of: data) {
                // Overwrite
                self.remove(at: index)
            }
        }
    }
}

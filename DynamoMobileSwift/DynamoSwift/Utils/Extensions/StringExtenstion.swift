//
//  StringExtenstion.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 2.07.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

extension String {
    var webUrlAddressFromString: URL? {
        guard !self.isEmpty else {
            return nil
        }
        
        var stringForURL: String?
        
        // add http in the beginning if required
        if hasPrefix("http://") || hasPrefix("https://") {
            stringForURL = self
        } else {
            stringForURL = "http://" + self
        }
        
        // add encoding for non latin strings
        let encodedString = stringForURL?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return URL(string: encodedString ?? "")
    }
}

//
//  UserData.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 1.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

class UserData: Codable {
    var username: String
    var slotURL: String = ""
    var slotName: String = ""
   // var selectedTenant: Tenant?
    var password: String?
    var isSSO: Bool = false
//    var currentUserKey: String {
//        return "\(username)-\(selectedTenant?.name ?? "")"
//    }
    var userGroup: String?
    
    init(with username: String) {
        self.username = username
    }
    
//    func updateWith(tenant: Tenant?, from slotURL: String, slotName: String) {
//        selectedTenant = tenant
//        self.slotURL = slotURL
//        self.slotName = slotName
//    }
}

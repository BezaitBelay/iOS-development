//
//  ContactDetailRepository.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 11.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

protocol ContactDetailRepositoryProtocol {
    func getEntityDataFor(_ itemID: String, itemType: String, completion: @escaping ((EntityDetailData?) -> Void))
    func postEntityDataFor(_ itemID: String, itemType: String, properties: [String: Any], completion: @escaping ((EntityDetailData?) -> Void))
}

class ContactDetailRepository: ContactDetailRepositoryProtocol {
    func getEntityDataFor(_ itemID: String, itemType: String, completion: @escaping ((EntityDetailData?) -> Void)) {
       guard !itemID.isEmpty else {
            return completion(nil)
        }
        let header = ["x-columns": "FullName, JobTitle, Comments, CompanyName, ContactInfo_Email, ContactInfo_BusinessPhone, ContactInfo_CompanyLink"]
        EntityDataRequest(pathParameters: [itemType, itemID], additionalHeaders: header)
            .executeParsed(of: EntityDetailData.self) { (itemData, _, _) in
                if let error = itemData?.error {
                    print("Request error: \(error)")
                }
                completion(itemData)
        }
    }
    
    func postEntityDataFor(_ itemID: String, itemType: String, properties: [String: Any], completion: @escaping ((EntityDetailData?) -> Void)) {
        let header = ["x-identifier": "true", "x-resolved": "false"]
        EntityUpdateRequest(pathParameters: [itemType, itemID], bodyJSONObject: properties, additionalHeaders: header)
            .executeParsed(of: EntityDetailData.self) {(entityData, _, _) in
                self.getEntityDataFor(itemID, itemType: itemType) { data in
                    let returnData = data?.data == nil ? entityData : data
                    completion(returnData)
                }
        }
    }
}

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
}

class ContactDetailRepository: ContactDetailRepositoryProtocol {
    func getEntityDataFor(_ itemID: String, itemType: String, completion: @escaping ((EntityDetailData?) -> Void)) {
//        let header = ["x-detailed": "true", "x-resolved": "false"]
        let header = ["x-columns": "FullName, JobTitle, Comments, CompanyName, Primarycontactemail, Primarycontactphone, ContactInfo_CompanyLink"]
        EntityDataRequest(pathParameters: [itemType, itemID], additionalHeaders: header)
            .executeParsed(of: EntityDetailData.self) { (itemData, _, _) in
                if let error = itemData?.error {
                    print("Request error: \(error)")
                }
                completion(itemData)
        }
    }
}

//
//  ContactsRepository.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 4.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

protocol ContactsRepositoryProtocol {
    func getEntitiesOf(type: String, nextPageURL: String?, completion: @escaping ((EntityData?) -> Void))
}

class ContactsRepository: ContactsRepositoryProtocol {
    func getEntitiesOf(type: String, nextPageURL: String?, completion: @escaping ((EntityData?) -> Void)) {
        let header: [String: String] = ["x-columns": "Identifier"]
        EntityDataRequest(pathParameters: [type],
                          queryParameters: nil,
                          additionalHeaders: header)
            .executeParsed(of: EntityData.self) { (entities, _, _) in
                completion(entities)
        }
    }
}

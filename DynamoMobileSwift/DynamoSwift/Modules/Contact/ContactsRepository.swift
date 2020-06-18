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
        let header: [String: String] = ["x-columns": "Identifier", "x-sort": "Identifier:asc"]
        let queryParams = getQueeryParansFromNext(from: nextPageURL)
        EntityDataRequest(pathParameters: [type],
                          queryParameters: queryParams,
                          additionalHeaders: header)
            .executeParsed(of: EntityData.self) { (entities, _, _) in
                completion(entities)
        }
    }
    
}
protocol ContactRepositoryHelper {
    func getQueeryParansFromNext(from nextPageURL: String?) -> [String: String]?
}

extension ContactsRepository: ContactRepositoryHelper {
    func getQueeryParansFromNext(from nextPageURL: String?) -> [String: String]? {
        var queryStrings = [String: String]()
        guard let nextPageURL = nextPageURL else { return nil }
        let splitURl = nextPageURL.components(separatedBy: "?")
        let params = splitURl[1]
        for pair in params.components(separatedBy: "&") {
            let key = pair.components(separatedBy: "=")[0]
            let value = pair
                .components(separatedBy: "=")[1]
                .replacingOccurrences(of: "+", with: " ")
                .removingPercentEncoding ?? ""
            
            queryStrings[key] = value
        }
        return queryStrings
    }
}

//
//  ContactApiClient.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

class ApiClient: BaseApiClientProtocol {
    func contacts(with endpoint: EntityEndpoint, completion: @escaping (Either<EntityData, ApiError>) -> Void) {
        let request = endpoint.request
        self.fetch(with: request) { (either: Either<EntityData, ApiError>) in
            switch either {
            case .value(let entity):
                let entity = entity.self
                completion(.value(entity))
            case .error(let error):
                completion(.error(error))
            }
        }
    }
}

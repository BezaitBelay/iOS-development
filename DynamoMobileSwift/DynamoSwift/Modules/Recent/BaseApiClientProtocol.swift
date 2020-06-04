//
//  ApiClient.swift
//  DynamoSwift
//
//  Created by Dynamo Software on 3.06.20.
//  Copyright © 2020 Upnetix. All rights reserved.
//

import Foundation

enum Either<V, E: Error> {
    case value(V)
    case error(E)
}

enum ApiError: Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknown(String)
}

protocol BaseApiClientProtocol {
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, ApiError>) -> Void)
}

extension BaseApiClientProtocol {
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either<V, ApiError>) -> Void) {
        let config = URLSessionConfiguration.default
        let apiKey = "LKQzc0a3IIeRq35muxFXr887rVePdivPlCB5nF1kQWHhawAD-UgPsQ-1scfZIWdgJZ7Vr0zYjQHM6xCzSGgQLQ"
        config.httpAdditionalHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.error(.apiError))
                return
            }
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.error(.badResponse))
                return
            }
            guard let data = data, let value = try? JSONDecoder().decode(V.self, from: data ) else {
                completion(.error(.jsonDecoder))
                return
            }
            
            completion(.value(value))
        }
        task.resume()
    }
}

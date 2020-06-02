//
//  NetworkingInterface.swift
//  NetworkKit
//
//  Created by Valentin Kalchev on 23.05.18.
//  Copyright © 2018 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol NetworkingInterface {
    
    var delegate: ReachabilityProtocol? { get set }
    
    func send(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func upload(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func retry(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func isConnectedToInternet() -> Bool
    
    func startNetworkReachabilityObserver()
}

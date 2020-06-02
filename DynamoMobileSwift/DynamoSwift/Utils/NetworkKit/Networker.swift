//
//  Networker.swift
//  NetworkKit
//
//  Created by Plamen Penchev on 4.09.18.
//

import Foundation
import Alamofire

public class Networker: NetworkingInterface {
    
    weak public var delegate: ReachabilityProtocol?
    let networkReachabilityManager = NetworkReachabilityManager()
    private var requestsCounter = 0
    private var retryActions: [(() -> Void)] = []
    
    public func send(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        let dataRequest = AF.request(request.asUrlRequest())
        getDataFrom(request: dataRequest, completion: completion)
    }
    
    public func retry(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        retryActions.append {[weak self] in
            self?.send(request: request, completion: completion)
        }
    }
    
    private func getDataFrom(request: DataRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        requestsCounter += 1
        request
            .response {[weak self] (response) in
                guard let strongSelf = self else { return }
                strongSelf.requestsCounter -= 1
                strongSelf.fireRetry(completion: completion)
                completion(response.data, response.response, response.error)
        }
    }
    private func fireRetry(completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard requestsCounter == 0, !retryActions.isEmpty else { return }
        let actions = retryActions
        for action in actions {
            action()
            _ = retryActions.removeFirst()
        }
    }
    
    public func upload(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        let params = request.bodyJSONObject as? [String: Any] ?? [:]
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            guard let upData = params["data"] as? Data,
                let name = params["name"] as? String,
                let filename = params["fileName"] as? String,
                let mimeType = params["mimeType"] as? String else {return}
            multipartFormData.append(upData, withName: name, fileName: filename, mimeType: mimeType)
        }, to: request.endpoint)
        
        request.response { (response) in
            completion(response.data, response.response, response.error)
            if let error = response.error {
                print("Can't upload: \(error.localizedDescription)")
                completion(nil, nil, response.error)
            }
        }
    }
    
    public func isConnectedToInternet() -> Bool {
        // swiftlint:disable:next force_unwrapping
        return (networkReachabilityManager?.isReachable)!
    }
    
    public func startNetworkReachabilityObserver() {
        delegate?.didChangeReachabilityStatus(isReachable: isConnectedToInternet())
        networkReachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            guard let strongSelf = self else { return }
            switch status {
                
            case .notReachable:
                strongSelf.delegate?.didChangeReachabilityStatus(isReachable: false)
                
            case .unknown :
                strongSelf.delegate?.didChangeReachabilityStatus(isReachable: false)
                
            case .reachable(.ethernetOrWiFi):
                strongSelf.delegate?.didChangeReachabilityStatus(isReachable: true)
                
            case .reachable(.cellular):
                strongSelf.delegate?.didChangeReachabilityStatus(isReachable: true)
            }
        })
    }
}

public protocol ReachabilityProtocol: class {
    func didChangeReachabilityStatus(isReachable: Bool)
}

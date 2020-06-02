//
//  APIManager.swift
//  NetworkKit
//
//  Created by Valentin Kalchev on 31.05.18.
//  Copyright © 2018 Valentin Kalchev. All rights reserved.
//

import Foundation

public protocol AuthenticationProtocol {
    func getApiToken(completion: ((String?) -> Void)?)
    func getLoginAccessToken(completion: ((String?) -> Void)?)
}

public protocol UrlSwitchingProtocol {
    var customBaseURL: String? {get}
    var customLoginURL: String? {get}
}

public protocol ApiManagerProtocol {
    var authToken: String? { get set }
    var baseURLs: BaseURLs { get }
    var environment: Environment { get set }
    var customBaseURL: String? {get}
    var delegate: StartLoginFlowDelegate? {get set}
    
    func sendRequest(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    func sendUploadRequest(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    func configure(withCacher: CacheableProtocol?, reachabilityDelegate: ReachabilityProtocol?,
                   andAuthenticator: AuthenticationProtocol?, andUrlSwitch: UrlSwitchingProtocol?,
                   delegate: StartLoginFlowDelegate?)
    func startReachabilityObserving()
    func isConnectedToInternet() -> Bool
}

public protocol StartLoginFlowDelegate: class {
    func startLoginFlow()
}

public final class APIManager: ApiManagerProtocol {
    public weak var delegate: StartLoginFlowDelegate?
    public static let shared = APIManager()
    private static let retryDelay = 1.5
    
    /// The API configuration, such as authentication token, environment, base urls, etc.
    private var config = APIConfig()
    private var cacher: CacheableProtocol?
    private var networker: NetworkingInterface = Networker()
    private var authenticator: AuthenticationProtocol?
    private var urlSwitch: UrlSwitchingProtocol?
    
    /// The currently used authentication token. Used for convenience and public accessibility, must always point to the APIConfig instance.
    public final var authToken: String? {
        set(newValue) {
            config.authToken = newValue
        }
        get {
            return config.authToken
        }
    }
    
    /// The currently used authentication token. Used for new Centralizet login convenience and public accessibility, must always point to the APIConfig instance.
    public final var accessToken: String? {
        set(newValue) {
            config.accessToken = newValue
        }
        get {
            return config.accessToken
        }
    }
    /// The current selected environments' base URLs. This should always return the values from the APIConfig instance.
    /// The APIConfig base URLs must NOT be publicly mutable, they're only set in
    /// EnvironmentsAndBaseURLs and held by the APIConfig instance.
    /// Used for convenience.
    public final var baseURLs: BaseURLs {
        return config.environment.value.baseURLs
    }
    
    public final var customBaseURL: String? {
        return urlSwitch?.customBaseURL
    }
    
    public final var customLoginURL: String? {
        return urlSwitch?.customLoginURL
    }
    
    /// The current selected environment in the APIConfig instance. Just for convenience and accessibility, should always point to the APIConfig instance.
    public final var environment: Environment {
        set(newValue) {
            config.environment = newValue
        }
        get {
            return config.environment
        }
    }
    /// Handles caching request execution.
    ///
    /// - Parameters:
    ///   - request: The APIRequest to be executed.
    ///   - completion: callback Data, Response, Error
    // swiftlint:disable:next function_body_length
    public final func sendRequest(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        networker.send(request: request) { [weak self] (data, urlResponse, error) in
            guard let strongSelf = self else { return }
            // Check if the authorization for the request fails and try to authenticate and re-send
            // the request again
            if let response = urlResponse, response.statusCode == 401,
                (request.tokenRefreshCount ?? 0) > 0,
                request.authorizationRequirement == .requiredForLogin {
                strongSelf.authenticator?.getLoginAccessToken { (token) in
                    strongSelf.accessToken = token
                    var updatedRequest = request
                    updatedRequest.tokenRefreshCount = (updatedRequest.tokenRefreshCount ?? 0) - 1
                    strongSelf.sendRequest(request: updatedRequest, completion: completion)
                    print("LOGIN UNAUTHORIZED, RETRY AUTHORIZATION. URL: \(request.endpoint)")
                    return
                }
            } else if let response = urlResponse, response.statusCode == 401, (request.tokenRefreshCount ?? 0) > 0 {
                strongSelf.authenticator?.getApiToken { (token) in
                    guard let token = token else {
                        strongSelf.delegate?.startLoginFlow()
                        print("RETURNED TO LOGIN SCREEN")
                        return
                    }
                    
                    strongSelf.authToken = token
                    var updatedRequest = request
                    updatedRequest.tokenRefreshCount = (updatedRequest.tokenRefreshCount ?? 0) - 1
                    strongSelf.sendRequest(request: updatedRequest, completion: completion)
                    print("UNAUTHORIZED, RETRY AUTHORIZATION. URL: \(request.endpoint)")
                    return
                }
            } else if let response = urlResponse, response.statusCode == 429 {
                print("RETRY REQUEST URL: \(request.endpoint)")
                delay(APIManager.retryDelay) {
                    strongSelf.sendRequest(request: request, completion: completion)
                }
            } else if request.shouldCache {
                if !strongSelf.networker.isConnectedToInternet() {
                    let cachedData = strongSelf.cacher?.loadCache(for: request)
                    completion(cachedData, urlResponse, ErrorsToThrow.noInternet)
                } else if let data = data {
                    // HANDLE Cache logic
                    strongSelf.cacher?.cache(data: data, for: request)
                    completion(data, urlResponse, error)
                } else {
                    completion(data, urlResponse, error)
                }
            } else {
                // Handle normal execution of request which should not be cached.
                // Custom error is passed if there's
                if !strongSelf.networker.isConnectedToInternet() {
                    completion(data, urlResponse, ErrorsToThrow.noInternet)
                } else {
                    completion(data, urlResponse, error)
                }
            }
        }
    }
    /// Handles caching request execution.
    ///
    /// - Parameters:
    ///   - request: The APIRequest to be executed.
    ///   - completion: callback Data, Response, Error
    public final func sendUploadRequest(request: APIRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        networker.upload(request: request) { [weak self] (data, urlResponse, error) in
            guard let strongSelf = self else { return }
            // Check if the authorization for the request fails and try to authenticate and re-send
            // the request again
            if let response = urlResponse, response.statusCode == 401, (request.tokenRefreshCount ?? 0) > 0 {
                strongSelf.authenticator?.getApiToken { (token) in
                    strongSelf.authToken = token
                    var updatedRequest = request
                    updatedRequest.tokenRefreshCount = (updatedRequest.tokenRefreshCount ?? 0) - 1
                    strongSelf.sendRequest(request: updatedRequest, completion: completion)
                    print("Debug: LOGIN UNAUTHORIZED, RETRY AUTHORIZATION. URL: \(request.endpoint)")
                    return
                }
                // HANDLE Cache logic
            } else if request.shouldCache {
                if !strongSelf.networker.isConnectedToInternet() {
                    let cachedData = strongSelf.cacher?.loadCache(for: request)
                    completion(cachedData, urlResponse, ErrorsToThrow.noInternet)
                } else if let data = data {
                    strongSelf.cacher?.cache(data: data, for: request)
                    completion(data, urlResponse, error)
                } else {
                    completion(data, urlResponse, error)
                }
            } else {
                // Handle normal execution of request which should not be cached.
                // Custom error is passed if there's
                if !strongSelf.networker.isConnectedToInternet() {
                    completion(data, urlResponse, ErrorsToThrow.noInternet)
                } else {
                    completion(data, urlResponse, error)
                }
            }
        }
    }
    
    /// Configure the APIManager cacher.
    ///
    /// - Parameter cacher: Class conforming to CacheableInterface.
    public final func configure(withCacher: CacheableProtocol?,
                                reachabilityDelegate: ReachabilityProtocol?,
                                andAuthenticator: AuthenticationProtocol?,
                                andUrlSwitch: UrlSwitchingProtocol?,
                                delegate: StartLoginFlowDelegate?) {
        cacher = withCacher
        networker.delegate = reachabilityDelegate
        authenticator = andAuthenticator
        urlSwitch = andUrlSwitch
        self.delegate = delegate
    }
    
    public final func startReachabilityObserving() {
        networker.startNetworkReachabilityObserver()
    }
    
    public final func isConnectedToInternet() -> Bool {
        return networker.isConnectedToInternet()
    }
}

// Error to pass when no connection is available.
public enum ErrorsToThrow: Error {
    case noInternet
    case retry
}

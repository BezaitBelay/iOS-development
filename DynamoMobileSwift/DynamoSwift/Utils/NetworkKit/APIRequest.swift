//
//  APIRequest.swift
//  NetworkKit
//
//  Created by Valentin Kalchev on 23.05.18.
//  Copyright © 2018 Valentin Kalchev. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", patch = "PATCH", delete = "DELETE"
}

private let defaultTimeout: TimeInterval = 30

/**
 Authorization requirement for current request.
 */
public enum AuthorizationRequirement {
    
    /// Request does not need authorization
    case none
    /// Request can have authorization, and may receive additional fields in response
    case allowed
    /// Request requires authorization
    case required
    /// Request requires authorization
    case requiredForLogin
}

public protocol APIRequest {
    var httpMethod: HTTPMethod {get}
    
    /// Base url(<host.com>). Must NOT end with "/"
    var baseUrl: BaseURL {get}
    
    var customUrlType: CustomBaseUrlType {get}
    
    /// Base path of the endpoint, without any possible parameters. Must begin with "/" and must NOT end with "/"
    var path: String {get}
    
    /// Parameters added to the path http://domain.com/path/{parameter1}/{parameter2}.
    /// Not to be confused with query parameters
    var pathParameters: [String]? {get set}
    
    /// Query parameters added to the pathParams http://domain.com/path/parameter{?queryItem=value&queryItem2=value}
    /// Pass key as queryItem and value for it's value
    var queryParameters: [String: String]? {get set}
    
    /// Added to the body as JSON Data.
    /// Must be of a valid JSON seriaizable type,
    /// such as Array [], Dictionary {}, String "Some string" OR already encoded JSON Data
    var bodyJSONObject: Any? {get set}
    
    /// Added to the body as form urlencoded.
    var bodyFormURLEncoded: [String: String]? {get set}
    
    var authorizationRequirement: AuthorizationRequirement {get}
    var headers: [String: String] {get}
    
    var shouldHandleCookies: Bool? {get}
    var shouldCache: Bool {get}
    var timeout: TimeInterval {get}
    var tokenRefreshCount: Int? {get set}
    
    var customCachingIdentifier: String {get}
    var customCachingIdentifierParams: [String: String]? {get set}
    
    var dynamicBaseURL: String? {get set}
    
    var additionalHeaders: [String: String]? {get set}
    
    init(pathParameters: [String]?, queryParameters: [String: String]?,
         bodyJSONObject: Any?, bodyFormURLEncoded: [String: String]?,
         parser: ParserInterface?,
         tokenRefreshCount: Int?,
         customCachingIdentifierParams: [String: String]?,
         dynamicBaseURL: String?,
         additionalHeaders: [String: String]?)
    
    var parser: ParserInterface? {get set}
}

extension APIRequest {
    func asUrlRequest() -> URLRequest {
        let endpointURL = URL(string: endpoint)
        // swiftlint:disable:next force_unwrapping
        var urlRequest = URLRequest(url: endpointURL!)
        var finalHeaders: [String: String]
        if let additionalHeaders = additionalHeaders {
            finalHeaders = headers.merging(additionalHeaders) { (_, new) in new }
        } else {
            finalHeaders = headers
        }
        urlRequest.allHTTPHeaderFields = finalHeaders
        urlRequest.httpMethod = httpMethod.rawValue
        let endpointString = endpointURL?.absoluteString ?? "missing url"
        print("Request method: \(httpMethod.rawValue) \npath: \(endpointString)")
        // TODO: Remove headers log
        print("Request final headers: \(finalHeaders)")
        // Set the http body, if a bodyJsonObject has been provided.
        if let bodyJSONObject = bodyJSONObject {
            // In case already encoded Data has been provided
            if let jsonData = bodyJSONObject as? Data {
                urlRequest.httpBody = jsonData
            } else {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: bodyJSONObject)
                    urlRequest.httpBody = jsonData
                } catch {
                     print("Serializing request json body object for: \(path): \(error.localizedDescription)")
                }
            }
        }
        
        /// Set the http body, if bodyFormURLEncoded has been provided.
        if let bodyFormURLEncoded = bodyFormURLEncoded {
            urlRequest.encodeParameters(parameters: bodyFormURLEncoded)
        }
        
        if let shouldHandleCookies = shouldHandleCookies {
            urlRequest.httpShouldHandleCookies = shouldHandleCookies
        }
        urlRequest.timeoutInterval = timeout
        return urlRequest
    }
    
    public func execute(completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        APIManager.shared.sendRequest(request: self, completion: completion)
    }
    
    public func executeUpload(completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        APIManager.shared.sendUploadRequest(request: self, completion: completion)
    }
    
    /// Executes the request and returns the actual parsed model in the callback.
    ///
    /// - Parameters:
    ///   - type: The model type to be parsed to.
    ///   - completion: callback (ParsedModel?, HTTPURLResponse?, Error?)
    public func executeParsed<T: Codable>(of type: T.Type, completion: @escaping (T?, HTTPURLResponse?, Error?) -> Void) {
        let startDate = Date()
        execute { (data, urlResponse, error) in
            var parsedData: T?
            let executionTime = Date().timeIntervalSince(startDate)
            // TODO: Log response ?
            print("Request duration: \(executionTime) with status code \(urlResponse?.statusCode ?? 0), with url: \(self.endpoint) for: \(self)")
            guard let data = data else {
                completion(parsedData, urlResponse, error)
                return
            }
            if let parser = self.parser {
                parsedData = parser.parse(data: data, ofType: type)
            } else {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                parsedData = try? decoder.decode(type, from: data)
            }
            
            if let error = error {
                print("Request fails: \(error.localizedDescription) for request \(self)")
            }
            completion(parsedData, urlResponse, error)
        }
    }
    
    public var endpoint: String {
        var urlComponents: URLComponents
        if let dynamicBaseURL = dynamicBaseURL {
            urlComponents = urlComponentsFrom(urlString: dynamicBaseURL)
        } else if customUrlType == .login,
            let customLoginURL = APIManager.shared.customLoginURL {
            let url = customLoginURL
            urlComponents = urlComponentsFrom(urlString: url)
        } else if customUrlType == .inApp,
            let customBaseURL = APIManager.shared.customBaseURL {
            let url = customBaseURL
            urlComponents = urlComponentsFrom(urlString: url)
        } else {
            urlComponents = urlComponentsFrom(urlString: baseUrl)
        }
        
        var fullPath = path
        if let pathParameters = pathParameters,
            pathParameters.count > 0 {
            pathParameters.forEach { (parameter) in
                if parameter.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 {
                    fullPath += "/\(parameter)"
                }
            }
        }
        urlComponents.path = fullPath
        
        if let queryParameters = queryParameters {
            var queryItems: [URLQueryItem] = []
            queryParameters.forEach {
                let item = URLQueryItem(name: $0.key, value: $0.value)
                queryItems.append(item)
            }
            urlComponents.queryItems = queryItems
        }
        return urlComponents.url?.absoluteString ?? ""
    }
    
    private func urlComponentsFrom(urlString: String) -> URLComponents {
        var urlComponents = URLComponents()
        if let url = URL(string: urlString) {
            urlComponents.scheme = url.scheme
            urlComponents.host = url.host
            urlComponents.port = url.port
        } else {
            if urlString.starts(with: "http://") {
                urlComponents.host = urlString.replacingOccurrences(of: "http://", with: "")
                urlComponents.scheme = "http"
            } else {
                urlComponents.host = urlString.replacingOccurrences(of: "https://", with: "")
                urlComponents.scheme = "https"
            }
        }
        return urlComponents
    }
}

// Support for parsing dict as form urlencoded content type
extension URLRequest {
    
    private func percentEscapeString(_ string: String) -> String? {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)?
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String: String]) {
        let parameterArray = parameters.compactMap { (arg) -> String in
            let (key, value) = arg
            guard let escpaedValue = percentEscapeString(value) else { return "\(key)=" }
            return "\(key)=\(escpaedValue)"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}

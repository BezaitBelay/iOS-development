////
////  NetworkKit+NoConnection.swift
////  MLiTP
////
////  Created by Plamen Penchev on 22.08.18.
////  Copyright © 2018 Upnetix. All rights reserved.
////
//
//import Foundation
//
////import UpnetixSystemAlertQueue
//
//typealias AlertTuple = (message: String, title: String)
//struct ErrorCodes {
//    static let timeout = 0
//}
//
//extension APIRequest {
//    
//    func executeParsedWithHandling<T: Codable>(of type: T.Type,
//                                               handlesNoNetwork: Bool = true,
//                                               handlesServerError: Bool = true,
//                                               errorParcer: ErrorParser? = nil,
//                                               completion: @escaping ((T?, HTTPURLResponse?, Error?) -> Void)) {
//        executeParsed(of: T.self) { (retrievedData, urlResponse, error) in
//            if handlesNoNetwork, (error as? ErrorsToThrow) == ErrorsToThrow.noInternet {
//                // If something has to be shown when request is initiated without internet, do it here!
//                print("ERROR: Offline for request \(self)")
//                let alertData: AlertTuple = (ErrorsAlerts.offlineMessage, ErrorsAlerts.offlineTitle)
//                let errorData = ErrorAlertData(alertData: alertData, shouldRetry: false)
//                self.showErrorAlert(with: type,
//                                    handlesNoNetwork: handlesNoNetwork,
//                                    handlesServerError: handlesServerError,
//                                    parsedError: errorData,
//                                    completion: completion)
//            } else if let response = urlResponse,
//                !response.statusCode.isSuccess,
//                handlesServerError {
//                print("ERROR in response: \(response.debugDescription) for request \(self) ")
//                let parsedError = errorParcer?.errorAlertData(for: response.statusCode)
//                if let parsedError = parsedError {
//                    self.showErrorAlert(with: type,
//                                        handlesNoNetwork: handlesNoNetwork,
//                                        handlesServerError: handlesServerError,
//                                        parsedError: parsedError,
//                                        completion: completion)
//                } else {
//                    completion(retrievedData, urlResponse, error)
//                }
//                
//            } else if handlesServerError, let error = error {
//                let parsedError = errorParcer?.errorAlertData(for: ErrorCodes.timeout)
//                if let parsedError = parsedError {
//                    self.showErrorAlert(with: type,
//                                        handlesNoNetwork: handlesNoNetwork,
//                                        handlesServerError: handlesServerError,
//                                        parsedError: parsedError,
//                                        completion: completion)
//                } else {
//                    completion(retrievedData, urlResponse, error)
//                }
//            } else {
//                completion(retrievedData, urlResponse, error)
//            }
//        }
//    }
//    
//    private func showErrorAlert<T: Codable>(with type: T.Type,
//                                            handlesNoNetwork: Bool = true,
//                                            handlesServerError: Bool = true,
//                                            parsedError: ErrorAlertData? = nil,
//                                            completion: @escaping ((T?, HTTPURLResponse?, Error?) -> Void)) {
//        guard let parsedError = parsedError else {
//            return
//        }
//        if parsedError.shouldRetry {
//            AlertFactoryManager.shared.presentRetryAlert(withMessage: parsedError.alertData.message,
//                                                         title: parsedError.alertData.title, retryBlock: {
//                self.executeParsedWithHandling(of: type,
//                                               handlesNoNetwork: handlesNoNetwork,
//                                               handlesServerError: handlesServerError,
//                                               completion: completion)
//            }, cancelBlock: {
//                completion(nil, nil, nil)
//            })
//        } else {
//            let okAktion = UIAlertAction(title: Strings.buttonOK, style: .cancel) { _ in
//                completion(nil, nil, nil)
//            }
//            AlertFactoryManager.shared.presentActionAlert(withMessage: parsedError.alertData.message,
//                                                          title: parsedError.alertData.title,
//                                                          withActions: [okAktion])
//        }
//    }
//}

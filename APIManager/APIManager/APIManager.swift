//
//  APIManager.swift
//  APIManager
//
//  Created by Avadh on 22/04/21.
//  Copyright © 2021 Avadh. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

public struct APIManager {
    static var provider = MoyaProvider<APITargetType>()
    
    @discardableResult
    public static func request<T>(
        _ target: APITargetType,
        decodeType type: T.Type,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: T) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void,
        completion completionCallback: @escaping () -> Void) -> Cancellable where T: Decodable {
        
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .customISO8601
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { (_ in) in})
        { (result) in
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let result = try decoder.decode(T.self, from: response.data)
                    successCallback(result)
                }
                catch let error {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                failureCallback(error)
            }
        }
        return cancellableRequest
    }
    
    @discardableResult
    public static func request(
        _ target: APITargetType,
        decoder: JSONDecoder = JSONDecoder(),
        dispatchQueue: DispatchQueue? = nil,
        success successCallback: @escaping (_ data: JSON) -> Void,
        error errorCallback: @escaping (_ message: String) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void) -> Cancellable {
        
        debugPrint("API:")
        debugPrint(target.baseURL.absoluteString + target.path)
        debugPrint("Header:")
        debugPrint(target.headers ?? [:])
        debugPrint("Parameters:")
        debugPrint(target)
        
        let cancellableRequest = provider.request(target, callbackQueue: nil, progress: { (_ in) in})
        { (result) in
            switch result {
            case let .success(response):
                let statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? HTTPStatusCode.ok
                if !statusCode.isSuccess {
                    let string = try? response.mapString()
                    let message = string ?? "no string error"
                    errorCallback(message)
                    return
                }
                do {
                    let jSon = try JSON(data: response.data)
                    successCallback(jSon)
                }
                catch let error {
                    debugPrint(error.localizedDescription)
                }
            case let .failure(error):
                debugPrint(error.localizedDescription)
                failureCallback(error)
            }
        }
        return cancellableRequest
    }
    
}

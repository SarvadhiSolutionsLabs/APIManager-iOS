//
//  APITargetType.swift
//  APIManager
//
//  Created by Avadh on 22/04/21.
//  Copyright © 2021 Avadh. All rights reserved.
//

import Foundation
import Moya

public struct APITargetType {
    
    private var BaseURL: URL!
    private var Path: String!
    private var Method: Moya.Method!
    private var Task: Task!
    private var Headers: [String: String]!
    
    @discardableResult
    public init(baseURL: URL, path: String, method: Moya.Method, task: Task, headers: [String: String]) {
        self.BaseURL = baseURL
        self.Path = path
        self.Method = method
        self.Task = task
        self.Headers = headers
    }
    
}

extension APITargetType: TargetType {
    public var baseURL: URL {
        return self.BaseURL
    }
    
    public var path: String {
        return self.Path
    }
    
    public var method: Moya.Method {
        return self.Method
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return self.Task
    }
    
    public var headers: [String: String]? {
        return self.Headers
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}


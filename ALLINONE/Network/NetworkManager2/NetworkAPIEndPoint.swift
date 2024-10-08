//
//  NetworkAPIEndPoint.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 02/03/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// EndPoint consists of various required properties
protocol NetworkAPIEndPoint: URLRequestable {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String]? { get }
}

extension NetworkAPIEndPoint {
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
}

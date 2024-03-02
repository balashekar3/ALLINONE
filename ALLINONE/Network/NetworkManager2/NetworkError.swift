//
//  NetworkError.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 02/03/24.
//

import Foundation

/// Error for network calls
enum NetworkError: Swift.Error, CustomStringConvertible {
    
    case apiError(Swift.Error)
    case invalidStatusCode(Int)
    case emptyData
    case invalidRequestURL(URL)
    case decodingError(DecodingError)
    case noInternet(URLError.Code)
    case somethingWentWrong

    public var description: String {
        switch self {
        case let .apiError(error):
            return "Network Error: \(error.localizedDescription)"
        case let .decodingError(decodingError):
            return "Json Decoding Error: \(decodingError.localizedDescription)"
        case .emptyData:
            return "Empty response from the server"
        case let .invalidRequestURL(url):
            return "Invalid URL. Please check the endPoint: \(url.absoluteString)"
        case .somethingWentWrong:
            return "Something went wrong."
        case let .invalidStatusCode(status):
            return "Server is down with status code: \(status)"
        case .noInternet(_):
            return "No Internet"
        }
    }
}

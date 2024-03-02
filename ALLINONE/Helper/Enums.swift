//
//  Enums.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit
enum Strings {
    static let cancel = "Cancel"
    static let ok = "OK"
    static let retry = "Retry"
    static let error = "Error"
    static let close = "Close"
    static let delete = "Delete"

    // Content
    static let appTitle = "APPTitle"
    static let searchPlaceHolder = "Search for data..."
}
/// App fonts size should be used from here
enum APP_FONT_SIZE: Float {
    case TITLE      = 20
    case DEFAULT    = 17
    case SUB_TITLE  = 14
    case SMALL      = 12
    case NANO       = 10
    case HEADER1    = 32
    case HEADER2    = 26
    case HEADER3    = 22
}

/// App font styles should be used from here
enum APP_FONT_STYLE: String {
    case LIGHT      = "HelveticaNeue-Light"
    case REGULAR    = "HelveticaNeue"
    case MEDIUM     = "HelveticaNeue-Medium"
    case BOLD       = "HelveticaNeue-Bold"
}

/// App images name should be used from here
enum APP_IMAGES: String {
    case Recent = "recent"
    case Delete = "delete"
}

/// App Colors shoud be used from here
enum APP_COLOR: String {
    case THEME = "3ca5dd"
    case SUB_THEME = "70c295"
}

/// App constants which are UI specific
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let defaultPadding: CGFloat = 8
    static let numberOfColumns: CGFloat = 3
    static let defaultRadius: CGFloat = 10
    static let defaultPageNum: Int = 0
    static let maximumPageNum: Int = 5
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 10
    static let defaultIconSize: CGFloat = 24
}

/// breaking down a screen in its common/mostly used states
public enum ViewState: Equatable {
    case loading
    case content
    case error(String)
    case none
}
//NetworkAPI Constants
enum APIConstants {
    static let baseURL = ""
    static let APIKey = ""
}
enum ComingFrom : String {
    case SplashViewController
    case SignInVC
    case SignUpVC
    case VerifyVC
    case ChangePasswordVC
    case ForgotPasswordVC
    case CoursePlaceOrderVC
}
enum RequestHeaders {
    static let contentType = "Content-Type"
    static let applicationJSON = "application/json"
    static let formData = "application/x-www-form-urlencoded"
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
}
enum RequestError: Error {
    case decode
    case invalidURL
    case invalidData
    case invalidResponse
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}
enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum APIEndpoint {
    case getAllProducts
//    case addProduct(bodyParms:AddProductRequestModel)
//    case login(bodyParms:LoginRequstModel)
//    case cart(limit:String)
//    case addToCart(bodyParms:AddToCartRequstModel)
}
extension APIEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "fakestoreapi.com"
    }
    
    var path: String {
        switch self {
        case .getAllProducts:
            return "/products"
//        case .addProduct:
//            return "/products"
//        case .login:
//            return "/auth/login"
//        case .cart:
//            return "/carts"
//        case .addToCart:
//            return "/carts"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllProducts:
            return .get
//        case .login,.addToCart,.addProduct:
//            return .post
            
        }
    }
    var parameters: [URLQueryItem]? {
        switch self {
//        case .cart(let limit):
//            return [URLQueryItem(name: "limit", value: limit)]
        default:
            return nil
        }
    }
    var header: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    var body: Encodable?{
        switch self {
        case .getAllProducts:
            return nil
            
//        case .login(bodyParms: let bodyParms):
//            return bodyParms
//        case .addToCart(bodyParms: let bodyParms):
//            return bodyParms
//        case .addProduct(bodyParms: let bodyParms):
//            return bodyParms
        }
    }
}

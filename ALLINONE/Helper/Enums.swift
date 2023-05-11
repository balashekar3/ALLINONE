//
//  Enums.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
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

//
//  Protocols.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation

protocol RegisterModelValidatorProtocol {
    func isUserNameValid(userName:String)->Bool
    func isPasswordValid(password:String)->Bool
    func isEmailValid(email:String)->Bool
    func isFirstNameValid(firstName:String) -> Bool
    func isLastNameValid(lastName:String)->Bool
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
    var parameters: [URLQueryItem]? { get }
}

protocol APIManagerProtocol {
    @available(iOS 15, *)
    func getDecodaleDataAsync<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type) async  -> Result<D, RequestError>
    func getDecodaleData<D: Decodable>(from endpoint: Endpoint,with responseModel: D.Type,completion: @escaping Handler<D>)
}

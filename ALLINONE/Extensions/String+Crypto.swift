//
//  String+Crypto.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation
import CryptoKit
private protocol ByteCountable{
    static var byteCount:Int {get}
}

extension Insecure.MD5:ByteCountable{}
extension Insecure.SHA1:ByteCountable{}
extension SHA256:ByteCountable{}

extension String{
    func md5(using encoding:String.Encoding = .utf8)->String{
        return self.hash(algo: Insecure.MD5.self,using: encoding)
    }
    func sha1(using encoding:String.Encoding = .utf8)->String{
        return self.hash(algo: Insecure.SHA1.self,using: encoding)
    }
    func sha256(using encoding:String.Encoding = .utf8)->String{
        return self.hash(algo: SHA256.self,using: encoding)
    }
    private func hash<Hash:HashFunction & ByteCountable>(algo:Hash.Type,using encoding:String.Encoding = .utf8) -> String{
        guard let data = self.data(using: encoding) else {
            return ""
        }
        return algo.hash(data: data).prefix(algo.byteCount).map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

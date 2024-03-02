//
//  Dictionary+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation
extension Dictionary{
    mutating func switchKey(fromKey: Key, toKey:Key){
        if let entry = removeValue(forKey: fromKey){
            self[toKey] = entry
        }
    }
    mutating func switchKey(_ keyMappings:[(Key,Key)]){
        for (fromKey, toKey) in keyMappings {
            if let value = self.removeValue(forKey: fromKey){
                self[toKey] = value
            }
        }
    }
    mutating func merge(dict: [Key:Value]){
        for (k,v) in dict{
            updateValue(v, forKey: k)
        }
    }
}

extension [String:AnyHashable] {
    func asData() -> Data? {
        var dict = [String:AnyHashable]()
        for (key,value) in self {
            if let hash = value.toHashable(){
                dict[key] = hash
            }
        }
        return try? JSONSerialization.data(withJSONObject: dict)
    }
    func toDataModel<T:Codable>() -> T?{
        guard let data = asData() else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension AnyHashable{
    func toHashable()->AnyHashable?{
        if let dict = self as? [String:AnyHashable]{
            var arr = [String:AnyHashable]()
            for (key,value) in dict{
                if let hash = value.toHashable(){
                    arr[key] = hash
                }
            }
            return arr
        } else if let value = self as? [AnyHashable] {
            var arr = [AnyHashable]()
            for item in value {
                if let hashed = item.toHashable(){
                    arr.append(hashed)
                }
            }
            return arr
        }else if let value = self as? (any RawRepresentable){
            return value.rawValue as? String
        }
        return self
    }
}

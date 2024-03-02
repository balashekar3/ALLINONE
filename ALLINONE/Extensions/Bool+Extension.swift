//
//  Bool+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation

extension Bool{
    func asInt() -> Int{
        return self ? 1 : 0
    }
    func asString() -> String {
        return self ? "true" : "false"
    }
}

//
//  String+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func removeSpecialChracter()->String{
        return replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
    }
}
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
extension String {
    static var empty: String {
        return ""
    }
    static var APIKeyParam: String {
        return "apikey"
    }
}

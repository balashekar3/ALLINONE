//
//  Double+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 28/01/24.
//

import Foundation
extension Double{
    func roundToDecimal(_ fractionDigits:Int) -> Double{
        let multiplier = pow(10, Double(fractionDigits))
        return (self * multiplier).rounded() / multiplier
    }
}

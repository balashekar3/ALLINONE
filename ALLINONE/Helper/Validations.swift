//
//  Validations.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
class Validations {
    
    static let sharedInstance = Validations()
    private init() {}
    
    func validateEmail(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._ %+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    func isValidPassword(text: String) -> Bool {
        let passwordRegex = "^(?=.\\d)(?=.[a-z])(?=.[A-Z])[0-9a-zA-Z!@#$%^&()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: text) }
    func validateAge(text: String) -> Bool {
        if text.count >= 2 {
            return true
        } else {
            return false
        }
    }
    func validateCardNumerLength(text: String) -> Bool {
        if text.count <= 19 {
            return true
        } else {
            return false
        }
    }
    func validateCardDateLength(text: String) -> Bool {
        if text.count >= 5 {
            return true
        } else {
            return false
        }
    }
    func validateCardCCVLength(text: String) -> Bool {
        if text.count <= 3 {
            return true
        } else {
            return false
        }
    }
    
    func validateMobileLength(text: String) -> Bool {
        if text.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    func validateMobile(value: String) -> Bool {
        let PHONE_REGEX = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    //^[1-9][0-9]{5}$
    func validatePincode(value: String) -> Bool {
        let PHONE_REGEX = "^[1-9][0-9]{5}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: value)
        return result
    }
    
    func validatePassword(text: String) -> Bool {
        if text.count >= 8 {
            return true
        } else {
            return false
        }
    }
    
    
    func validateName(text: String) -> Bool {
        if text.count > 0 {
            return true
        } else {
            return false
        }
    }
    func validateContryCodeLength(text: String) -> Bool {
        if text.count <= 1 && text.count >= 5 {
            return true
        } else {
            return false
        }
    }
}

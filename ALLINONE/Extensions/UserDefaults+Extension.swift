//
//  UserDefaults+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 07/03/23.
//

import Foundation
class Defaults {
    enum Keys: String, CaseIterable {
        case regToken
        case isPhoneVerified
        case firstLaunch
        
    }
    
    func cleanAllkeys(excepts: [Keys]?) {
        for key in Keys.allCases {
            if excepts?.contains(key) == true {
                continue
            } else {
                UserDefaults.standard.set(nil, forKey: key.rawValue)
                UserDefaults.standard.synchronize()
            }
        }
    }
    var regToken: String {
        get {
            return UserDefaults.standard.object(forKey: Keys.regToken.rawValue) as? String ?? ""
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.regToken.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    var isPhoneVerified: Int {
        get {
            return UserDefaults.standard.value(forKey: Keys.isPhoneVerified.rawValue) as? Int ?? 0
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.isPhoneVerified.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    var firstLaunch: Bool {
        get {
            return UserDefaults.standard.object(forKey: Keys.firstLaunch.rawValue) as? Bool ?? true
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.firstLaunch.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    
}

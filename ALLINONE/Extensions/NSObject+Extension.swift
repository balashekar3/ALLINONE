//
//  NSObject+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 07/03/23.
//

import Foundation
import UIKit
extension NSObject {
    
    var appDelegate: AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
}

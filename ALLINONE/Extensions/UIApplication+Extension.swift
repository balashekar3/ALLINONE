//
//  UIApplication+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 01/03/24.
//

import Foundation
import UIKit
extension UIApplication {
    var statusView: UIView? {
        if #available(iOS 13.0, *) {
            let tag = 38482
            if let statusBar = UIWindow.key?.viewWithTag(tag) {
                return statusBar
            } else {
                let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBarView.tag = tag

                UIWindow.key?.addSubview(statusBarView)
                return statusBarView
            }
        } else {
            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

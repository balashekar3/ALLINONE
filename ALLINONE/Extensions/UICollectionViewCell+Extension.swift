//
//  UICollectionViewCell+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 07/03/23.
//

import Foundation
import UIKit
extension UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

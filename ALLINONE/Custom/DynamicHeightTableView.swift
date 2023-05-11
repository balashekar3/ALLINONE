//
//  DynamicHeightTableView.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit
final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

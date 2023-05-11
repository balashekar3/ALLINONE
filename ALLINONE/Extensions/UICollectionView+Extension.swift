//
//  UICollectionView+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 05/05/23.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func configureCVAddSub(_ bgColor: UIColor = .clear, ds: UICollectionViewDataSource, dl: UICollectionViewDelegate, view: UIView) {
        configureCV(bgColor, ds: ds, dl: dl)
        view.addSubview(self)
    }
    
    func configureCV(_ bgColor: UIColor, ds: UICollectionViewDataSource, dl: UICollectionViewDelegate) {
        contentInsetAdjustmentBehavior = .never
        backgroundColor = bgColor
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        dataSource = ds
        delegate = dl
        translatesAutoresizingMaskIntoConstraints = false
        reloadData()
    }
}

//
//  LoadingIndicatorView.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit

class LoadingIndicatorView: UIView {
    private let activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createLoadingView(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createLoadingView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    }
    
    private func createLoadingView(frame: CGRect) {
        activityIndicator.style = .large
        activityIndicator.color = .lightGray
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        activityIndicator.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addSubview(activityIndicator)
        
        let loadingTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 240, height: 25))
        loadingTextLabel.numberOfLines = 0
        loadingTextLabel.center.x = activityIndicator.center.x
        loadingTextLabel.center.y = activityIndicator.center.y + 50
        loadingTextLabel.textAlignment = .center
        loadingTextLabel.text = "Please wait.."
        loadingTextLabel.textColor = .white
        //loadingTextLabel.font = UIFont.GulfRegular(withSize: FontSize.tiny)
        addSubview(loadingTextLabel)
    }
    
    func startAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
    }
    func stopAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
        
    }
}


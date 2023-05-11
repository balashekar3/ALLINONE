//
//  UIViewController+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { _ in
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(settingsUrl)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertToast(message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .actionSheet)
        self.present(alert, animated: true)
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func showActivityIndicator() -> Bool {
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor.darkGray
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        activityIndicator.tag = 99
        for subview in self.view.subviews {
            if subview.tag == 99 {
                return false
            }
        }
        self.view.addSubview(activityIndicator)
        self.view.isUserInteractionEnabled = false
        return true
    }
    
    func hideActivityIndicator() {
        let activityIndicator = self.view.viewWithTag(99) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

//For disply xib type viewcontroller
extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
}

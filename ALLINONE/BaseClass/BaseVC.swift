//
//  BaseVC.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 07/03/23.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    static var window: UIWindow?
    var isFromSignUp: Bool = false
    let comingFrom = AppDelegate.shared?.comingFrom
    //StatusBarText Color
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        updateViewController()
    }
    override func viewWillLayoutSubviews() {
        setStatusBar(backgroundColor:UIColor(red: 0.044, green: 0.219, blue: 0.408, alpha: 1))
    }
    func updateViewController() {
        let name = String(describing: type(of: self))
        if name != "VerifyVC" {
            AppDelegate.shared?.comingFrom = ComingFrom(rawValue: name) ?? ComingFrom(rawValue: "SignInVC")!
        }
    }
    //StatusBarBG Color
    private func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    func showAlert(withTitle title: String, andMessage message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancel(withTitle title: String, andMessage message: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .cancel, handler: completion)
        let noAction = UIAlertAction(title: "No", style: .default, handler: completion)
        alert.addAction(noAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleUnauthorizedError(){
        showAlert(withTitle:"Message", andMessage: "Unknown error. Please try after some time.", completion: { action in
        })
    }
    
}

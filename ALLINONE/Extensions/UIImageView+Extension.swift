//
//  UIImageView+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage? = UIImage(named: "NoImage")) {
        
        self.image = placeHolder
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            //            debugPrint("image got from cachedImage")
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data)?.imageResized(to: CGSize(width: 200.0, height: 200.0)) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            //                            debugPrint("got downloadedImage")
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}
extension UIImageView {
    
    func makeRounded() {
        
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
extension UIImageView {
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.contentMode = mode
                self?.backgroundColor = .clear
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension UIImageView{
    func configureIMGViewForCell(_ contentView: UIView, imgName: String, ctMore: UIView.ContentMode = .scaleAspectFit) {
        contentMode = ctMore
        clipsToBounds = true
        image = UIImage(named: imgName)?.withRenderingMode(.alwaysTemplate)
        tintColor = .black
        contentView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}

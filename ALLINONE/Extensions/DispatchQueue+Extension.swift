//
//  DispatchQueue+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
import UIKit
extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }

}



//Usage

//DispatchQueue.background(delay: 3.0, background: {
//    // do something in background
//}, completion: {
//    // when background job finishes, wait 3 seconds and do something in main thread
//})
//
//DispatchQueue.background(background: {
//    // do something in background
//}, completion:{
//    // when background job finished, do something in main thread
//})
//
//DispatchQueue.background(delay: 3.0, completion:{
//    // do something in main thread after 3 seconds
//})


//Type2-DispatchQueue

//DispatchQueue.global(qos: .userInitiated).async {
//    print("This is run on a background queue")
//
//    DispatchQueue.main.async {
//        print("This is run on the main queue, after the previous code in outer block")
//    }
//}

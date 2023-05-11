//
//  FindMenoryAddress.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 09/03/23.
//

import Foundation
class FindMenoryAddress {
    static func printReferenceTypeAddress(reference:AnyObject){
        debugPrint(Unmanaged.passUnretained(reference).toOpaque())
    }
    static func printValueTypeAddress(value:UnsafeRawPointer){
        let bitPattern = Int(bitPattern: value)
        debugPrint(NSString(format: "%p", bitPattern))
    }
}

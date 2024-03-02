//
//  Array+Extension.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 11/05/23.
//

import Foundation
extension Array{
    subscript(safeIndex index:Int)->Iterator.Element?{
        return index >= 0 && index < endIndex ? self[index] : nil
    }
    
    subscript(safe index:Index) -> Element?{
        get{indices.contains(index) ? self[index] : nil}
        set {
            guard let element = newValue,
                  indices.contains(index) else {
                return
            }
            self[index] = element
        }
    }
    mutating func prepend(_ newElement:Element){
        insert(newElement, at: 0)
    }
}

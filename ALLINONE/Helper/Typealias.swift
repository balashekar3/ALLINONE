//
//  Typealias.swift
//  ALLINONE
//
//  Created by Balashekar Vemula on 08/03/23.
//

import Foundation
typealias Handler<T> = (Result<T, RequestError>) -> Void

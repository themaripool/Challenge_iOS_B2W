//
//  Pokemon.swift
//  Challenge_iOS_B2W
//
//  Created by Mariela Mendonça de Andrade on 15/07/21.
//

import Foundation

struct Root : Decodable {
    let count               : Int
    let next                : String
    let results             : [Pokemon]
}

struct Pokemon: Codable, Hashable {
    var name                : String
    var url                 : String
}

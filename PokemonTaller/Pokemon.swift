//
//  Pokemon.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import Foundation

class Pokemon: Mappable {
    var id: Int?
    var name: String?
    var order: Int?
    var sprites: Sprite?
    var isDefault: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case order
        case sprites
        case isDefault = "is_default"
    }
    
}

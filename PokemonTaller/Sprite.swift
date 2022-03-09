//
//  Sprite.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import Foundation

class Sprite: Mappable {
    var backDefault: String?
    var frontDefault: String?
    
    private enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}

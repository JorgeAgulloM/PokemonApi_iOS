//
//  Sprite.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import Foundation

class Sprite: Mappable {
    var back_default: String?
    var front_default: String?
    var other: Other?
}

class Other: Mappable {
    var home: Home?
}

class Home: Mappable {
    var front_default: String?
    
    /**
     "official-artwork": {
             "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png"
           }
     */

}

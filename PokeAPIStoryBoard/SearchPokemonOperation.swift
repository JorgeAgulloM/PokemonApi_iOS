//
//  SearchPokemonOperation.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

class SearchPokemonOperation: Operation {
    
    let viewController: ViewController
    let ID_POKEMON_MAX: Int
    
    
    init (_ viewController: ViewController, _ ID_POKEMON_MAX: Int) {
        self.viewController = viewController
        self.ID_POKEMON_MAX = ID_POKEMON_MAX
    }
    
    override func main() {
        var pokemonsList: Array<Pokemon> = []
        for id in 1...ID_POKEMON_MAX {
            Conection().getPokemon(withId: id) {
                pokemon in
                
                if let pokemon = pokemon {
                    
                    pokemonsList.append(pokemon)
                    print("Pokemon: \(pokemon.name ?? "Sin nombre") añadido")
//                    Conection().getSprite(with: pokemon.sprites?.front_default ?? "") {
//                        image in
//
//                        print("Se añade a: \(pokemon.name!)")
//                        DispatchQueue.main.async {
//                            self.viewController.self.refreshList(pokemon: pokemon)
//                        }
//
//                    }
                    
                } else {
                    print("Algo está fallando con id: \(id)")
                }
            }//Fin del connexion
            viewController.progressUpdateOnlyForGlobalThread(Float(id))
        }//Fin del for
        print("Yo yaa****")
        viewController.refreshListPokemonsOnlyForGlobalThread(pokemonsList: pokemonsList)
    }
}

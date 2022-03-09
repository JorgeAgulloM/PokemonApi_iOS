//
//  ViewController.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var backPokemon: UIButton!
    @IBOutlet weak var nextPokemon: UIButton!
    @IBOutlet weak var loadingPokemon: UIActivityIndicatorView!
    
    let PKMN_MIN: Int = 1
    let PKMN_MAX: Int = 898
    var pokemonId: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resfreshView()
        loadPokemon()
    }
    
    func loadPokemon() {
        Connection().getPokemon(withId: pokemonId) {
            pokemon in
            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.namePokemon.text = pokemon.name
                }
                
                Connection().getSprite(withUrl: pokemon.sprites?.front_default ?? "" ) {
                    sprite in
                    if let sprite = sprite {
                        DispatchQueue.main.async {
                            self.imagePokemon.image = sprite
                            self.resfreshView()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.resfreshView()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.resfreshView()
                }
            }
        }
    }
    
    func selectPokemon(_ goTo: Bool = false) {
        resfreshView()
        if goTo {
            pokemonId = pokemonId < PKMN_MAX ? pokemonId + 1 : PKMN_MIN
        } else {
            pokemonId = pokemonId > PKMN_MIN ? pokemonId - 1 : PKMN_MAX
        }
    }
    
    func resfreshView() {
        backPokemon.isEnabled.toggle()
        nextPokemon.isEnabled.toggle()
        if !backPokemon.isEnabled {
            loadingPokemon.startAnimating()
            imagePokemon.image = UIImage(named: "pokeBall")
            namePokemon.text = "Pokemon"
        } else {
            loadingPokemon.stopAnimating()
        }
        imagePokemon.isHidden.toggle()
        namePokemon.isHidden.toggle()
    }
    
    @IBAction func goToBackPokemon(_ sender: UIButton) {
        selectPokemon()
        loadPokemon()
    }
    
    @IBAction func goToNextPokemon(_ sender: UIButton) {
        selectPokemon(true)
        loadPokemon()
    }
    
}


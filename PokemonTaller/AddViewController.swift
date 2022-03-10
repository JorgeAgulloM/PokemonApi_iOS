//
//  AddViewController.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 10/3/22.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var pokemonNameTextField: UITextField!
    
    public var pokemon: Pokemon?
    public var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savePokemon" {
            savePokemon()
        }
    }
    
    func savePokemon() {
        if let pokemonName = pokemonNameTextField.text, !pokemonName.isEmpty {
            print("Enviando pokemon \(pokemonName)")
            let newPokemon = Pokemon()
            newPokemon.name = pokemonName
            let newImage = UIImage(imageLiteralResourceName: "chetos")
            
            self.pokemon = newPokemon
            self.image = newImage
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

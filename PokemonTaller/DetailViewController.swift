//
//  DetailViewController.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var switIsDefault: UISwitch!
    
    public var pokemon: Pokemon?
    public var pokemonImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pokemon = pokemon {
            namePokemon.text = pokemon.name
        }
        
        if let pokemonImage = pokemonImage {
            imagePokemon.image = pokemonImage
        }
        
        if let isDefault = pokemon?.isDefault {
            switIsDefault.isOn = isDefault
            view.backgroundColor = .gray
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

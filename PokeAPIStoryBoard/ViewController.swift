//
//  ViewController.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var pokemonsList: Array<Pokemon> = []
    let ID_POKEMON_MIN: Int = 1
    let ID_POKEMON_MAX: Int = 898
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
            loadPokemons()
    }
    
    func loadPokemons() {
        for pokemonId in ID_POKEMON_MIN...50{
            
            Conection().getPokemon(withId: pokemonId) {
                pokemon in
                
                if let pokemon = pokemon {
                    //print("Encontrado nuevo pokemon con id: \(pokemonId)")
                    Conection().getSprite(with: pokemon.sprites?.front_default ?? "") {
                        image in
                        
                        if image != nil {
                            self.pokemonsList.append(pokemon)
                            print("Encontrado Pokemon con nombre: \(self.pokemonsList[self.pokemonsList.endIndex - 1].name ?? "Deconocido") y con id: \(pokemonId)")
                            DispatchQueue.main.async {
                                print("recargando")
                                self.myTableView.reloadData()
                            }
                        }
                    }
                } else {
                    print("Algo está fallando con id: \(pokemonId)")
                }
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(!isEditing, animated: true)
        
        myTableView.setEditing(!myTableView.isEditing, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ myTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsList.count
    }
    
    func tableView(_ myTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonTableViewCell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        as! PokemonTableViewCell
        
        cell.delegate = self
        
        let pokemon = pokemonsList[indexPath.row]
        
        cell.pokemonName.text = pokemon.name
        
        let url = URL(string: pokemon.sprites?.front_default ?? "")
        let data = try? Data(contentsOf: url!)
        if let image = data {
            cell.pokemonImage.image = UIImage(data: image)
        }

        
        return cell
        
        
    }
    
    func callPressed(name: String) {
        print("Llamando a ")
    }

}


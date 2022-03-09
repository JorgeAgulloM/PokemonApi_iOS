//
//  MytableViewController.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import UIKit

class MytableViewController: UITableViewController, MyCellDelegate {
    

    let FIRST_PKMN: Int = 0
    let PKMN_MAX: Int = 50
    var pokemonList: Array<Pokemon> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPokemons()
    }
    
    func loadPokemons() {
        //pokemonList = [Pokemon?](repeating: nil, count: PKMN_MAX)
        print("Empezamos")
        for i in FIRST_PKMN...PKMN_MAX {
            Connection().getPokemon(withId: i) { pokemon in
                if let pokemon = pokemon {
                    self.pokemonList.append(pokemon)//insert(pokemon, at: i)
                    DispatchQueue.main.async {
                        if self.pokemonList.count == self.PKMN_MAX {
                            self.pokemonList.sort { (uno: Pokemon, dos: Pokemon) in
                                return uno.id! < dos.id!
                            }
                            
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PokemonCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PokemonCell
        
        cell.namePokemon.text = pokemonList[indexPath.row].name
        
        let url = pokemonList[indexPath.row].sprites?.front_default ?? ""
        
        Connection().getSprite(withUrl: url) { sprite in
            if let sprite = sprite {
                DispatchQueue.main.async {
                    cell.imagePokemon.image = sprite
                }
            } else {
                DispatchQueue.main.async {
                    cell.imagePokemon.image = UIImage(named: "pokeBall")
                }
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func callPressed(name: String) {
        print("hola")
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

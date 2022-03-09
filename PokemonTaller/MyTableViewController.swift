//
//  MyTableViewController.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import UIKit

class MyTableViewController: UITableViewController {

    var pokemons: [Pokemon?] = []
    var images: [UIImage?] = []
    let MAX_POKEMONS = 50
    var imagesDownload = 0
    var connection = Connection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = "Pokemons"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        pokemons = [Pokemon?](repeating: nil, count: MAX_POKEMONS)
        images = [UIImage?](repeating: nil, count: MAX_POKEMONS)
        
        downloadPokemonsInfo()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PokemonCell

        // Configure the cell...
        if let pokemon = pokemons[indexPath.row] {
            cell.namePokemon.font = UIFont(name: "Pokemon Solid", size: 20)
            cell.namePokemon.text = pokemon.name ?? "Desconocido"
        }
        
        if let image = images[indexPath.row] {
            cell.imagePokemon.image = image
            cell.loadPokemon.stopAnimating()
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func downloadPokemonsInfo() {
        for i in 1...MAX_POKEMONS {
            connection.getPokemon(withId: i) { pokemon in
                
                if let pokemon = pokemon, let id = pokemon.id {
                    self.pokemons[id - 1] = pokemon
                    
                    if let image = pokemon.sprites?.frontDefault {
                        self.connection.getSprite(withUrl: image) { sprite in
                            self.imagesDownload += 1
                            
                            if let sprite = sprite {
                                self.images[id - 1] = sprite
                            }
                            
                            if self.imagesDownload == self.MAX_POKEMONS {
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}

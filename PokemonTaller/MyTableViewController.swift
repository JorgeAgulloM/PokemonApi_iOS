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
    var firstLoad: Bool = false
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteBarButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        title = "Pokemons"
        deleteBarButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !firstLoad {
            pokemons = [Pokemon?](repeating: nil, count: MAX_POKEMONS)
            images = [UIImage?](repeating: nil, count: MAX_POKEMONS)
            
            downloadPokemonsInfo()
            firstLoad = true
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PokemonCell

        // Configure the cell...
        if let pokemon = pokemons[indexPath.row] {
            cell.namePokemon.font = UIFont(name: "Pokemon Solid", size: 25)
            cell.namePokemon.text = pokemon.name ?? "Desconocido"
            
            cell.namePokemon.textColor = .red
        }
        
        if let image = images[indexPath.row] {
            cell.imagePokemon.image = image
            cell.loadPokemon.stopAnimating()
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            self.performSegue(withIdentifier: "goToDetailSegue", sender: indexPath)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokemons.remove(at: indexPath.row)
            images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        let pokemonMove = pokemons[fromIndexPath.row]
        let imageMove = images[fromIndexPath.row]
        
        pokemons.remove(at: fromIndexPath.row)
        images.remove(at: fromIndexPath.row)
        
        pokemons.insert(pokemonMove, at: to.row)
        images.insert(imageMove, at: to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailSegue" {
            if let detailVC = segue.destination as? DetailViewController ,
               let indexPath = tableView.indexPathForSelectedRow,
               let pokemon = pokemons[indexPath.row],
               let image = images[indexPath.row] {
                detailVC.pokemonImage = image
                detailVC.pokemon = pokemon
                
            }
        }
    }
    
    @IBAction func setEditmode(_ sender: UIBarButtonItem) {
        tableView.isEditing.toggle()
        editBarButton.title = tableView.isEditing ? "Done" : "Edit"
        deleteBarButton.isEnabled = tableView.isEditing
    }
    

    @IBAction func DeleteRowSelected(_ sender: UIBarButtonItem) {
        if let selectRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectRows {
                pokemons.remove(at: indexPath.row)
                images.remove(at: indexPath.row)
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: selectRows, with: .automatic)
            tableView.endUpdates()
        }
    }
    
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    
    @IBAction func save(segue: UIStoryboardSegue) {
        if let addVC = segue.source as? AddViewController,
           let newPokemon = addVC.pokemon,
           let newImage = addVC.image {
            
            pokemons.append(newPokemon)
            images.append(newImage)
            tableView.reloadData()
        }
    }
    
}

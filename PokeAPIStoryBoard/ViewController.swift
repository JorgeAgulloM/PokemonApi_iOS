//
//  ViewController.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate {
    
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    var progressUpdate: Float = 0
    
    var pokemonsList: Array<Pokemon> = []
    
    let ID_POKEMON_MIN: Int = 1
    let ID_POKEMON_MAX: Int = 50//898
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        myTableView.delegate = self
        myTableView.dataSource = self
        
        loadPokemons()
    }
    
    func loadPokemons() {
        startStop()
        var pokemonsList: Array<Pokemon> = []
            for id in 1...self.ID_POKEMON_MAX {
                Conection().getPokemon(withId: id) {
                    pokemon in
                    
                    if let pokemon = pokemon {
                        pokemonsList.append(pokemon)
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
                    self.progressUpdateOnlyForGlobalThread(Float(id))
                    
                }
            }
        
        //Se declara un hilo con retardo para esperar a la carga de la información
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            self.refreshListPokemonsOnlyForGlobalThread(pokemonsList: pokemonsList)
            
        }
    }
    
    
    func startStop(_ stop: Bool = false) {
        if !stop {
            indicatorLabel.text = "0"
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            loadLabel.text = "Cargando Pokemons"
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            self.myTableView.isHidden = false
            loadLabel.text = "Pokemons cargados"
        }
    }
    
    func progressUpdateOnlyForGlobalThread(_ n: Float) {
        //  Se calcula el porcentaje con el número del usuario
        if progressUpdate < 100.0 {
            progressUpdate = (Float(n) * 100.0) / Float(ID_POKEMON_MAX) }
        
        //  Se actualizan marcadores de progreso
        DispatchQueue.main.async {
            self.progressBar.progress = self.progressUpdate / 100
            self.indicatorLabel.text = "\( Int(self.progressUpdate))%"
            
        }
    }
    
    func refreshListPokemonsOnlyForGlobalThread(pokemonsList: Array<Pokemon>) {
        /**
         students.sort { (lhs: String, rhs: String) -> Bool in
             return lhs > rhs
         }
         */
        self.pokemonsList = pokemonsList
        self.pokemonsList.sort { (uno: Pokemon, dos: Pokemon) in
            return uno.id! < dos.id!
        }
        
        
        DispatchQueue.main.async {
            print("Reloading")
            self.myTableView.reloadData()
            self.startStop(true)
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
        
        //En caso de no tener información, aparecerá el texto predefinido de la celda
        if let id: Int = pokemon.id {
            if let name: String = pokemon.name {
                cell.pokemonName.text = ("ID: \(id), Nombre \(name)")
            }
        }
        
        //En caso de no tener imagen, aparecerá la imagen predeficinda de la celda
        if let url = URL(string: pokemon.sprites?.front_default ?? "") {
            if let data = try? Data(contentsOf: url) {
                cell.pokemonImage.image = UIImage(data: data)
            }
        }
        
        indicatorLabel.text = "\(pokemonsList.count)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Intercambia la imagen de la celda seleccionada, en el array, front_default de baja calidad por una de alta calidad en other.home.from_default
        let firstImageInArray = pokemonsList[indexPath.row].sprites?.front_default
        let secondImageInArray = pokemonsList[indexPath.row].sprites?.other?.home?.front_default
        pokemonsList[indexPath.row].sprites?.front_default = secondImageInArray
        pokemonsList[indexPath.row].sprites?.other?.home?.front_default = firstImageInArray
        myTableView.reloadData()

    }
    
    //Sin uso
    //delegate?.callPressed(name: .text ?? "") Para usar este método
    func callPressed(name: String) {
        print("Llamando a \(name)")
    }

}


//
//  ViewController.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCellDelegate {
    
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var myTableView: UITableView!
    
    var progressUpdate: Float = 0
    
    var pokemonsList: Array<Pokemon> = []
    
    //Variables de control
    let ID_POKEMON_MIN: Int = 1
    let ID_POKEMON_MAX: Int = 50//898
    var pokemonsDownLoad: Int = 0
    var CompleteDownload: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //Lanza la carga de los pokemon
        loadPokemons()
        
    }
    
    //Lanza las conexiones para cada pokemon. En la variable de control pokemonsDownLoad se lleva la cuenta de los pokemons recuperados o su intento.
    func loadPokemons() {
        //Función de puesta a 0
        startStop()
            for id in 1...self.ID_POKEMON_MAX {
                Connection().getPokemon(withId: id) {
                    pokemon in
                    
                    if let pokemon = pokemon {
                        self.pokemonsList.append(pokemon)
                        self.pokemonsDownLoad += 1
                        
                    } else {
                        self.pokemonsDownLoad += 1
                    
                    }
                    
                    //Función de control de progreso
                    self.progressUpdateOnlyForGlobalThread(Float(id))
                    
                }
            }
        //Se lanza un hilo que espera a la descarga de todos los pokemons solicitados.
        waitForAllDownloads()
        
    }
    
    //Función para reiniciar contadores o mostrar el resultado final
    func startStop(_ stop: Bool = false) {
        if !stop {//Start
            indicatorLabel.text = "0"
            progressBar.progress = 0
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            loadLabel.text = "Cargando Pokemons..."
            
        } else {//Stop
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            myTableView.isHidden = false
            loadLabel.text = "Pokemons cargados!"
            indicatorLabel.text = "\(pokemonsList.count)"
            
        }
    }

    //Función para esperar a que todos los pokemon esperados estén descarados
    func waitForAllDownloads() {
        //Se carga en un hilo de ejecución en global y se abre un bucle, con un segundo de pausa por cada iteración, para esperar a tenerlos todos
        DispatchQueue.global().async {
            repeat {
                if self.pokemonsDownLoad >= self.ID_POKEMON_MAX  && !self.CompleteDownload{
                    self.refreshListPokemonsOnlyForGlobalThread(pokemonsList: self.pokemonsList)
                    self.CompleteDownload = true

                }
                //Para que no haya un bucle haciendo iteraciones sin sentido se pausa un segunda en cada una de ellas.
                sleep(1)
            } while !self.CompleteDownload
            
        }
    }
    
    //Función para el control del progreso
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
    
    //Función para proceder a cargar la lista en la tabla ¡¡SOLO SE DEBE UTILIZAR DESDE UN HILO SECUNDARIO!!!
    func refreshListPokemonsOnlyForGlobalThread(pokemonsList: Array<Pokemon>) {
        
        self.pokemonsList.sort { (uno: Pokemon, dos: Pokemon) in
            return uno.id! < dos.id!
            
        }
        
        //Se abre un hilo en main para realizar el reload
        DispatchQueue.main.async {
            self.myTableView.reloadData()
            self.startStop(true)
            
        }
    }
    
    //#############################################################Métodos própios de la tabla
    //
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(!isEditing, animated: true)
        myTableView.setEditing(!myTableView.isEditing, animated: true)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ myTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsList.count
        
    }
    
    func tableView(_ myTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Se carga la celda personalizada
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
        
        print("Pokemons \(pokemonsList.count)")
        
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


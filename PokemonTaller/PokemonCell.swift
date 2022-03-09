//
//  PokemonCell.swift
//  PokemonTaller
//
//  Created by Jorge Agullo Martin on 9/3/22.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var loadPokemon: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

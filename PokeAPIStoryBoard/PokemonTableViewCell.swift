//
//  PokemonTableViewCell.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

protocol MyCellDelegate {
    func callPressed(name: String)
}

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    var delegate: MyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

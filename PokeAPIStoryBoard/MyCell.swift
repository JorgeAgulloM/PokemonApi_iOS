//
//  MyCell.swift
//  PokeAPIStoryBoard
//
//  Created by Jorge Agullo Martin on 16/2/22.
//

import UIKit

protocol MyCellDelegate {
    func callPressed(name: String)
}

class MyCell: UITableViewCell {
    
    @IBOutlet weak var imageMyCell: UIImageView!
    @IBOutlet weak var testTittle: UILabel!
    var delegate: MyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}

//
//  CellPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Sanket Patel  on 2023-01-28.
//

import UIKit

class CellPokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imagePokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

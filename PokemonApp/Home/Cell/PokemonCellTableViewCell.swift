//
//  PokemonCellTableViewCell.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import UIKit
import Reusable
import Kingfisher

class PokemonCellTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(pokemon: Pokemon?) {
        guard let pokemon else { return }
        
        self.pokemonName.text = pokemon.name
        
        if let urlImage = pokemon.sprites?.frontDefault {
            let url = URL(string: urlImage)
            pokemonImage.kf.setImage(with: url)
        }
    }
    
}

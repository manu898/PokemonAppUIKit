//
//  DetailViewController.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation
import UIKit
import Reusable

protocol DetailViewControllerDelegate: AnyObject {
    func favoriteAction(pokemon: Pokemon)
}

class DetailViewController: UIViewController {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    weak var homeVC: HomeViewController?
    
    weak var delegate: DetailViewControllerDelegate?
    
    var viewModel: ViewModel?
    
    var pokemon: Pokemon? {
        didSet {
            guard oldValue != pokemon else { return }
            configData()
        }
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        guard let pokemon else { return }
        
        delegate?.favoriteAction(pokemon: pokemon)
        sender.backgroundColor = pokemon.inFavorites ? .blue : .white
        homeVC?.favoritesList?.append(pokemon)
    }
    
    func configData() {
        guard isViewLoaded, let pokemon else { return }
        
        pokemonName.text = pokemon.name ?? ""
        
        pokemonImage.layer.cornerRadius = 10
        
        if let url = URL(string: pokemon.sprites?.frontDefault ?? "") {
            pokemonImage.kf.setImage(with: url)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Detail", bundle: nil)
    }
}

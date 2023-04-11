//
//  HomeViewController.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation
import UIKit
import Reusable

protocol HomeViewControllerDelegate: AnyObject {
    func goToDetails(_ homeViewController: HomeViewController, pokemon: Pokemon)
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: HomeViewControllerDelegate?
    
    var viewModel: ViewModel?
    
    var pokemonList: [Pokemon]? {
        didSet {
            guard oldValue != pokemonList else { return }
            
            tableView.reloadData()
        }
    }
    
    var favoritesList: [Pokemon]? {
        didSet {
            guard oldValue != favoritesList else { return }
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
    }
    
    func registerCell() {
        tableView.register(cellType: PokemonCellTableViewCell.self)
    }
}

//MARK: Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = viewModel?.pokemonList?[indexPath.row] else { return }
        
        delegate?.goToDetails(self, pokemon: pokemon)
    }
}

//MARK: DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.pokemonList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as PokemonCellTableViewCell
        
        let pokemon = viewModel?.pokemonList?[indexPath.row]
        
        cell.config(pokemon: pokemon)
        
        return cell
    }
}

//MARK: Reusable
extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: nil)
    }
}

//
//  DetailAppCoordinator.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation
import UIKit

class DetailAppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var viewModel: ViewModel?
    
    var homeVC: HomeViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailVC = DetailViewController.instantiate()
        detailVC.homeVC = homeVC
        detailVC.viewModel = viewModel
        navigationController.pushViewController(detailVC, animated: true)
    }
}

extension DetailAppCoordinator: DetailViewControllerDelegate {
    func favoriteAction(pokemon: Pokemon) {
        viewModel?.favoriteAction(pokemon: pokemon)
    }
}

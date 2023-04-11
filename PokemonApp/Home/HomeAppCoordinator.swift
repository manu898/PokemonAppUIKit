//
//  FirstAppCoordinator.swift
//  Interview
//
//  Created by Manuel Caparrelli on 11/04/23.
//

import Foundation
import UIKit
import Reusable

class HomeAppCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var viewModel: ViewModel?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        homeVC.viewModel = viewModel
        homeVC.delegate = self
        navigationController.pushViewController(homeVC, animated: true)
    }
}

//MARK: HomeViewControllerDelegate
extension HomeAppCoordinator: HomeViewControllerDelegate {
    func goToDetails(_ homeViewController: HomeViewController, pokemon: Pokemon) {
        let detailCoordinator = DetailAppCoordinator(navigationController: navigationController)
        detailCoordinator.homeVC = homeViewController
        detailCoordinator.viewModel = viewModel
        childCoordinator.append(detailCoordinator)
        detailCoordinator.start()
    }
}

//
//  MainCoordinator.swift
//  AcronymCodeChallenge1
//
//  Created by admin on 24/01/2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let networkmanager = NetworkManager()
        let viewModel = AcronymViewModel(repository: networkmanager as! AcronymListRepository)
        let vc = AcronymSearchViewController(viewModel: viewModel)
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    
    
}

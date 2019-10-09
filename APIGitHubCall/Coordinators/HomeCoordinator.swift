//
//  HomeCoordinator.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    
    var homeViewController: HomeViewController?
    var repoCoordinator: RepoCoordinator?
    
    init(presenter: UINavigationController) {
        
        self.presenter = presenter

    }
    
    func start() {
        let homeViewController = HomeViewController(nibName: nil, bundle: nil)
        homeViewController.title = Project.Localizable.Home.selfTitle.localized
        
        self.homeViewController = homeViewController
        self.homeViewController?.homeDelegate = self
        presenter.pushViewController(self.homeViewController ?? homeViewController, animated: true)
    }
}
// MARK: END HomeCoordinator to extensions

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelect(tag: Int) {
        
        if tag == 46 {
            
            let repoCoord = RepoCoordinator(presenter: presenter)
            self.repoCoordinator = repoCoord

            repoCoordinator?.start()
        }
    }
    
}

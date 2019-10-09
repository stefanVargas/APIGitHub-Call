//
//  RepoCoordinator.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

class RepoCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private var homeViewController: HomeViewController?
    private var repoViewController: ReposTableViewController?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let repoViewController = ReposTableViewController(nibName: nil, bundle: nil)
        repoViewController.title = "X" //Project.Localizable.
        presenter.pushViewController(repoViewController, animated: true)
        
        self.repoViewController = repoViewController
    }
    
}

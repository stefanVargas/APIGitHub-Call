//
//  ApplicationCoordinator.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var homeCoordinator: HomeCoordinator

    
    init(window: UIWindow) {
        
        self.window = window
        rootViewController = UINavigationController()
        
        rootViewController.navigationBar.appUINavigationBarLayout()
        rootViewController.navigationBar.backgroundColor = .white
        
        homeCoordinator = HomeCoordinator(presenter: rootViewController)

    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        homeCoordinator.start()


    }
}

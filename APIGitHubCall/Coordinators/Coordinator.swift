//
//  Coordinator.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: class {
    func start()
    
    func stop()
    
}

extension Coordinator {
    
    func stop() { }
}


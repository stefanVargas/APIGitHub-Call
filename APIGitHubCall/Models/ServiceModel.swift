//
//  Repositorie.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation

struct GitHubAPIService: Decodable {
    
    var total_count: Int?
    var incomplete_results: Bool?
    var items: [Repositories.Repositorie]
    
    struct GitRepositorie: Decodable  {
        var id: Int?
        var name: String?
        var owner: Repositories.Repositorie.Owner
        var stargazers_count: Int?
        
    }
}






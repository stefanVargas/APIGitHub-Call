//
//  Repositorie.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 11/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation

struct GitHubAPIService: Decodable {
    
    var totalCount: Int?
    var items: [Repositories.Repositorie]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    struct GitRepositorie: Decodable  {
        
        var name: String?
        var owner: Repositories.Repositorie.Owner
        var starCount: Int?
        
        private enum CodingKeys: String, CodingKey {
            case starCount = "stargazers_count"
            case owner
            case name
        }
        
    }
}






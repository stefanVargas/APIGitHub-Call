//
//  Repositorie.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation

struct Repositories {
        
    var repositories: [Repositorie]

    struct Repositorie: Codable  {
     
        
        var id: Int?
        var name: String?
        var owner: Owner?
        var stargazers_count: Int?
        
        struct Owner: Codable  {
            var id: Int?
            var login: String?
            var avatar_url: String?
        }
    }
    
}


// MARK: END Repositorie to extensions

extension Repositories {
    
    init(from service: GitHubAPIService) {

        repositories = []

        for gitRepo in service.items {
            var repositorie = Repositorie()

            repositorie.name = gitRepo.name
            repositorie.id = gitRepo.id
            repositorie.owner = gitRepo.owner

            self.repositories.append(repositorie)
        }

    }
    
}

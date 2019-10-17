//
//  Repositorie.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 11/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation
import UIKit

struct Repositories {
        
    var repositories: [Repositorie]

    struct Repositorie: Codable  {
     
        var name: String?
        var owner: Owner?
        var starCount: Int?
        
        private enum CodingKeys: String, CodingKey {
                   case starCount = "stargazers_count"
                   case owner
                   case name
               }

        
        struct Owner: Codable  {
            var id: Int?
            var login: String?
            var avatarUrl: String?
            
            private enum CodingKeys: String, CodingKey {
                case avatarUrl = "avatar_url"
                case login
                case id
            }
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
            repositorie.starCount = gitRepo.starCount
            repositorie.owner = gitRepo.owner

            self.repositories.append(repositorie)
        }

    }
    
}

//
//  Repositorie.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation

struct API: Decodable {
    
    var total_count: Int?
    var incomplete_results: Bool?
    var items: Repositorie?
}


struct Repositorie: Decodable  {
    var id: Int?
    var name: String?
    var owner: Owner?
    var stargazers_count: Int?
}

struct Owner: Decodable  {
    var id: Int?
    var login: String?
    var avatar_url: String?
}

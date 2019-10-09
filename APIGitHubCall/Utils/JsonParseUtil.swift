//
//  JsonParseUtil.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation


class JsonParseUtil {
    
    class func fetchRepositoriesData(with request: Repositorie, page: Int, completion: @escaping () -> ()) {
        
        guard let url = URL(string: Project.url) else { return }
        
        let parameters = ["page"]
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
        }
    }
}

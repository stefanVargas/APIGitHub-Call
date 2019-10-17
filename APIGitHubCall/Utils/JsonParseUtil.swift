//
//  JsonParseUtil.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 11/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation


class JsonParseUtil {
    
    class func fetchRepositoriesData(page: Int, completion: @escaping (Result<GitHubAPIService, Error>) -> ()) {
                
        let pageUrl =  Project.url + page.description

        guard let url = URL(string: pageUrl) else { return }
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            guard let decodedData = try? JSONDecoder().decode(GitHubAPIService.self, from: data) else {
                
                guard let erro = err else { return }
                completion(Result.failure(erro))
                return
            }
                        
            completion(Result.success(decodedData))
        }.resume()
        
    }
    
}

//
//  LocalizableConstants.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Foundation


struct Project {
    
    static let url = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
    
    static let requestUrl = "https://api.github.com/search/repositories"
    
    static let defaultImage = "Github"
    
    enum Fonts: String {
        case courierBold = "Courier-Bold"
        case courier = "Courier"
        case gillSans = "GillSans"
    }
    
    enum Localizable {
        
        enum Home: String {
            case selfTitle = "git.home.title"
            case welcomeTitle = "git.home.welcome.title"
            case infoTitle  = "git.home.info.title"
            case buttonTitle  = "git.home.button.title"
        }
        
        enum Repo: String {
            case selfTitle = "git.repo.title"
            case refresh = "git.repo.refresh.text"
        }
    }
    
}

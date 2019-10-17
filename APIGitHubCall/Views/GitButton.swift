//
//  GitButton.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 10/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class GitButton: UIButton {
     
    //MARK: Atributes
    static var identifier: String {
        return String(describing: self)
    }
    
    let gitButtonTag = 46
    
    init(frame: CGRect, interaction: Bool) {
        
        super.init(frame: frame)
        setupButton()
        
        self.isUserInteractionEnabled = interaction
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupButton()
    }
    
    func setupButton()  {
        
        self.tag = gitButtonTag
        
        self.backgroundColor =  .gitBlack
        self.layer.borderColor = UIColor.gitWhite.cgColor
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 5
                
        self.contentVerticalAlignment = .center
        self.contentHorizontalAlignment = .center
        
        self.setTitle( Project.Localizable.Home.buttonTitle.localized, for: .normal)
        self.titleLabel?.font = UIFont(name: Project.Fonts.courierBold.rawValue, size: 16)
        self.setTitleColor(.gitWhite, for: .normal)
        self.setTitleColor(.gitGray, for: .highlighted)
    }
    
}

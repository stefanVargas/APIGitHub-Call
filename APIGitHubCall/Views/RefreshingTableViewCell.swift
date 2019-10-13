//
//  RefreshingTableViewCell.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 11/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class RefreshingTableViewCell: UITableViewCell {
   
    //MARK: Atributes
    typealias VF = VisualFormat
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let loaderSign : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.color = .gitGray
        
        return loader
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
        
    }
    
    private func setupViews() {
        addSubview(loaderSign)

        setupContraint(pattern: VF.fullHorSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: loaderSign)
        setupContraint(pattern: VF.fullVerSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterX, views: loaderSign)

    }

}

//
//  GitRepoTableViewCell.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class GitRepoTableViewCell: UITableViewCell {
    
    typealias VF = VisualFormat
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let loaderSign : UIActivityIndicatorView = {
        
        let loader = UIActivityIndicatorView()
        loader.color = .gitGray
        return loader
    }()
    
    let insideView: UIView = {
        
        let cv = UIView()
        
        return cv
    }()
    
    var repoNameLabel: UILabel! = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courierBold.rawValue, size: 12)
        lbl.textColor = UIColor.gitBlack
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    
    var authorNameLabel: UILabel! = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courier.rawValue, size: 10)
        lbl.textColor = UIColor.gitDarkGray
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    var starsLabel: UILabel! = {
        
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.gillSans.rawValue, size: 16)
        lbl.textColor = UIColor.gitMagenta
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    var photo: UIImageView = {
        
        let img = UIImageView()
        img.contentMode = UIView.ContentMode.scaleAspectFit
        img.setAsCircle()
        
        return img
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
        
        let sizer = SizeHandler(view: self)
        let tenPercentH = sizer.percentOfFrame(percent: 10, dimension: .height)
        
        addSubview(loaderSign)
        addSubview(starsLabel)
        addSubview(photo)
        addSubview(insideView)
        insideView.addSubview(repoNameLabel)
        insideView.addSubview(authorNameLabel)
        
        setupContraint(pattern: VF.fullHorSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: loaderSign)
        setupContraint(pattern: VF.fullVerSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterX, views: loaderSign)

        setupContraint(pattern: VF.fullVerDefault, views: photo)
        setupContraint(pattern: VF.fullVerTotal, views: insideView)
        setupContraint(pattern: VF.fullVerDefault, views: starsLabel)
        setupContraint(pattern: "H:|-[v0][v1][v2]-|", views: photo,insideView,starsLabel)
     
        insideView.setupContraint(pattern: "V:|-[v0]-(==\(tenPercentH)-[v1]-|",options: NSLayoutConstraint.FormatOptions.alignAllCenterX, views: repoNameLabel, authorNameLabel)
        insideView.setupContraint(pattern: VF.fullHorDefault, views: repoNameLabel)
        insideView.setupContraint(pattern: VF.fullHorDefault, views: authorNameLabel)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

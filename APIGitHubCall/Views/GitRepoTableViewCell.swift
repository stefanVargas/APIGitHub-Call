//
//  GitRepoTableViewCell.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 10/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class GitRepoTableViewCell: UITableViewCell {
    
    //MARK: Atributes
    typealias VF = VisualFormat
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let insideView: UIView = {
        let cv = UIView()
        
        return cv
    }()
    
    static let holderImage = UIImage(named: Project.defaultImage)
    
    var repoNameLabel: UILabel! = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courierBold.rawValue, size: 13)
        lbl.textColor = UIColor.gitBlack
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        
        return lbl
    }()
    
    
    var authorNameLabel: UILabel! = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courier.rawValue, size: 10)
        lbl.textColor = UIColor.gitDarkGray
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        
        return lbl
    }()
    
    var starsLabel: UILabel! = {
        let lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courierBold.rawValue, size: 14)
        lbl.textColor = UIColor.gitMagenta
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        
        return lbl
    }()
    
    var photo: UIImageView = {
        
        let imgView = UIImageView(image: holderImage)
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        imgView.setRoundedCorners()
        imgView.isAccessibilityElement = false
        
        return imgView
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
        let sixPercentHeight = sizer.percentOfFrame(percent: 6, dimension: .height)
        let widthQuarter = sizer.quarterFrame(dimension: .width)
        let widthPart = sizer.percentOfFrame(percent: 30.25, dimension: .width)
        self.backgroundColor = .white
        
        addSubview(starsLabel)
        addSubview(photo)
        addSubview(insideView)
        insideView.addSubview(repoNameLabel)
        insideView.addSubview(authorNameLabel)

        setupContraint(pattern: VF.fullVerSmall, views: photo)
        setupContraint(pattern: VF.fullVerDefault, views: insideView)
        setupContraint(pattern: "V:|-4-[v0]-4-|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, views: starsLabel)
        setupContraint(pattern: "H:|-[v0(\(widthQuarter))]-2-[v1(\(widthPart * 1.25))][v2]-|", views: photo,insideView,starsLabel)
     
        insideView.setupContraint(pattern: "V:|-[v0]-(\(sixPercentHeight * 1.75))-[v1]|", views: repoNameLabel, authorNameLabel)
        insideView.setupContraint(pattern: VF.fullHorDefault, options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: repoNameLabel)
        insideView.setupContraint(pattern: VF.fullHorDefault, options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: authorNameLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

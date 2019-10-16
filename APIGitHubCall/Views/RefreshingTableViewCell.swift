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
    
    let photoPlaceHolder = UIView()
    
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
        
        
        let sizer = SizeHandler(view: self)
        let widthQuarter = sizer.quarterFrame(dimension: .width)

        self.backgroundColor = .gitDarkModeBackground
        self.photoPlaceHolder.alpha = 0.75
        
        glowColor()
        
        addSubview(photoPlaceHolder)
        addSubview(loaderSign)
        
        setupContraint(pattern: VF.fullVerBig, views: photoPlaceHolder)
        setupContraint(pattern: "H:|-[v0(\(widthQuarter * 1.15))]", views: photoPlaceHolder)
        
        setupContraint(pattern: VF.fullHorSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: loaderSign)
        setupContraint(pattern: VF.fullVerSmall,options: NSLayoutConstraint.FormatOptions.alignAllCenterX, views: loaderSign)
        self.accessibilityLabel = Project.Localizable.Accessiblity.loading.localized
    }
    
    func glowColor() {
        photoPlaceHolder.backgroundColor = .white
        let opacity: Float = 0.15
        self.photoPlaceHolder.setGlow(radius: 5, opacity: opacity, color: [.gitWhite, .gitGray, .gitMagenta, .gitBlack])
        
        
    }
    
}

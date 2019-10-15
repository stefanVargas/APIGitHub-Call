//
//  HomeViewController.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func homeViewControllerDidSelect(tag: Int)
}

class HomeViewController: UIViewController {
    
    //MARK: Atributes
    typealias VF = VisualFormat

    weak var homeDelegate: HomeViewControllerDelegate?
    
    let welcomeLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.gillSans.rawValue, size: 18)
        lbl.textColor = UIColor.gitDarkGray
        lbl.text = Project.Localizable.Home.welcomeTitle.localized
        lbl.textAlignment = .center
        
        return lbl
    }()
    
    let infoLabel: UILabel = {
        var lbl = UILabel()
        lbl.font = UIFont(name: Project.Fonts.courier.rawValue, size: 13)
        lbl.textColor = UIColor.gitDarkGray
        lbl.text = Project.Localizable.Home.infoTitle.localized
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        
        return lbl
    }()
    
    let gitButton = GitButton(frame: CGRect.zero, interaction: true)
    
    let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)

    

    // MARK: HomeViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllerViews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        gitButton.addTarget(self, action: #selector(continueToNextViewController), for: .touchUpInside)
        
    }
    
    
    // MARK: HomeViewController Setup Methods
    func setupControllerViews()  {
        let sizer = SizeHandler(view: self.view)
        let tenPercentH = sizer.percentOfFrame(percent: 10, dimension: .height)
        let quarterH = sizer.quarterFrame(dimension: .height)
        
        self.view.backgroundColor = .white

        self.view.addSubview(welcomeLabel)
        self.view.addSubview(infoLabel)
        self.view.addSubview(gitButton)
        
        self.view.setupContraint(pattern: VF.fullHorDefault, options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: welcomeLabel)
        self.view.setupContraint(pattern: VF.fullHorSmall, options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: infoLabel)
         self.view.setupContraint(pattern: VF.fullHorSmall, options: NSLayoutConstraint.FormatOptions.alignAllCenterY, views: gitButton)
        
        self.view.setupContraint(pattern: "V:|-(==\(quarterH))-[v0]-16-[v1]-(==\(tenPercentH))-[v2(==\(quarterH/4))]", views: welcomeLabel, infoLabel, gitButton)
        
    }
    
    // MARK: HomeViewController Auxiliar Methods
    @objc func continueToNextViewController() {
        self.homeDelegate?.homeViewControllerDidSelect(tag: gitButton.tag)
        impactFeedbackgenerator.impactOccurred()
        
    }

}

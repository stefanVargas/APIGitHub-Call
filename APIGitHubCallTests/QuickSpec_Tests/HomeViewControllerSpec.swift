//
//  HomeViewControllerSpec.swift
//  APIGitHubCallTests
//
//  Created by Stefan V. de Moraes on 14/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick
@testable import APIGitHubCall

class HomeViewControllerSpec: QuickSpec {
    override func spec(){
        var sut: HomeViewController?
        var view: UIView?
        
        describe("HomeViewController"){
            beforeEach{
                
                sut = HomeViewController()
                sut?.viewDidLoad()
                
                view = sut?.view
                
            }
            context("HomeViewController Layout and initalization") {
                it("should init properly") {
                    sut?.setupControllerViews()
                    
                    expect(sut?.welcomeLabel).toNot(beNil())
                    expect(sut?.infoLabel).toNot(beNil())
                    expect(sut?.gitButton).toNot(beNil())
                    
                }
                
                it("should have stable Layout ") {
                    sut?.setupControllerViews()
                    
                    expect(view) == snapshot("home_view")
                    
                }
                
                it("should init colors properly ") {
                    sut?.setupControllerViews()
                    
                    expect(sut?.gitButton.backgroundColor).to(equal(.gitBlack))
                    
                }
                
            }
            context("HomeViewController Labels") {
                it("can show the correct text within the welcome label") {
                    expect(sut?.welcomeLabel.text).to(equal(Project.Localizable.Home.welcomeTitle.localized))
                }
                it("can show the correct information label") {
                    expect(sut?.infoLabel.text).to(equal(Project.Localizable.Home.infoTitle.localized))
                }
                
            }
            
            afterEach {
                sut = nil
            }
        }
        
    }
    
}

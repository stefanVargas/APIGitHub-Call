//
//  CoordinatorSpec.swift
//  APIGitHubCallTests
//
//  Created by Stefan V. de Moraes on 14/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Nimble
import Quick
@testable import APIGitHubCall

class CoordinatorSpec: QuickSpec {
    override func spec(){
        var sut1: HomeCoordinator?
        var sut2: RepoCoordinator?
        var presenter: UINavigationController?
        let gitButtonTag = 46

        
        describe("Coordinators"){
            beforeEach{
                presenter = UINavigationController()
                sut1 = HomeCoordinator(presenter: presenter ?? UINavigationController())
                sut2 = RepoCoordinator(presenter: presenter ?? UINavigationController())
            }
            
            context("Start Coordinators") {
                it("should init properly") {
                    sut1?.start()
                    sut2?.start()

                    expect(sut1?.homeViewController).toNot(beNil())
                    expect(sut2?.repoViewController).toNot(beNil())

                }
                
                it("should call delegate") {
                    sut1?.start()
                    sut1?.homeViewControllerDidSelect(tag: gitButtonTag)
                    
                    expect(sut2?.repoViewController).toNot(beNil())

                }

            }
            
            context("Stop Coordinators") {
                it("should stop properly") {
                    sut1?.stop()
                    sut2?.stop()
                    
                    expect(sut1?.homeViewController).to(beNil())
                    expect(sut2?.repoViewController).to(beNil())

                }
                
            }
            
            afterEach {
                sut1 = nil
                sut2 = nil

            }
        }
        
    }
    
}


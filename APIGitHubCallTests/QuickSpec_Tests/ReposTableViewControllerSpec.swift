//
//  ReposTableViewControllerSpec.swift
//  APIGitHubCallTests
//
//  Created by Stefan V. de Moraes on 14/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import Nimble
import Nimble_Snapshots
import Quick
@testable import APIGitHubCall

class ReposTableViewControllerSpec: QuickSpec {
    override func spec(){
            var sut: ReposTableViewController?
            var view: UIView?

        
        describe("ReposTableViewController"){
            beforeEach{
                
                sut = ReposTableViewController()
                sut?.viewDidLoad()
                view = sut?.view
                
            }
            
            context("ReposTableViewController Layout and initalization") {
                it("should init properly") {
                    sut?.setupView()
                    sut?.setupTableView()
                    
                    expect(sut?.repoTableView).toNot(beNil())
                }
                
                it("should have stable Layout ") {
                    sut?.setupView()
                    sut?.overrideUserInterfaceStyle = .light
                    
                    expect(view) == snapshot("repositories_view_iPhone8")
                }
                
                it("should have stable TableView ") {
                    sut?.setupView()
                    sut?.setupTableView()
                    let table = sut?.repoTableView
                    sut?.overrideUserInterfaceStyle = .light

                    
                    expect(table) == snapshot("repositories_tableview_iPhone8")
                }
                
            }
            
            context("ReposTableViewController Objetcs") {
                
                beforeEach {
                    JsonParseUtil.fetchRepositoriesData(page: 0){ result in
                        
                        if let service = try? result.get() {
                            sut?.repoList = Repositories(from: service)
                        }
                        else {
                            return
                        }
                    }
                }
                
                it("should have a Repositories List ") {
                                        
                    expect(sut?.repoList).toEventually(beNil())
                }
                
            }
            
            afterEach {
                sut = nil
            }
        }
        
    }
    
}

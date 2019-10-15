//
//  APIGitHubCallTests.swift
//  APIGitHubCallTests
//
//  Created by Stefan V. de Moraes on 13/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import XCTest
@testable import APIGitHubCall

class APIGitHubCallTests: XCTestCase {
        
    var homeVC: HomeViewController?
    var homeCoordinator: HomeCoordinator?
    var repoTableVC: ReposTableViewController?
    var repoCoordinator: RepoCoordinator?
    var repos: Repositories?

    override func setUp() {
        
        homeCoordinator = HomeCoordinator(presenter: UINavigationController())
        repoCoordinator = RepoCoordinator(presenter: UINavigationController())
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeCoordinator?.stop()
        repoCoordinator?.stop()
        
    }
    
    func testHomeViewController(){
        homeCoordinator?.start()
        homeVC = homeCoordinator?.homeViewController
        let delegate = homeVC?.homeDelegate
        homeVC?.setupControllerViews()
        let gBtn = GitButton(frame: CGRect.zero, interaction: true)
        let ifg = homeVC?.impactFeedbackgenerator
        gBtn.setupButton()
        delegate?.homeViewControllerDidSelect(tag: 1)

        XCTAssertNotNil(delegate, "Delegate is Not Nil")
        XCTAssertNotNil(ifg, "Impact FeedBack is Not Nil")
        XCTAssertEqual(gBtn.backgroundColor, .gitBlack, "Button Background must be black")
        XCTAssertEqual(gBtn.tag, 46, "Button Tag must be 46")
        XCTAssertEqual(homeVC?.view.backgroundColor, .white, "Background must be white")

    }

    func testRepoTableViewController(){
        repoCoordinator?.start()
        repoTableVC = repoCoordinator?.repoViewController
        repoTableVC?.setupView()
        repoTableVC?.setupTableView()
        self.repos = repoTableVC?.repoList
        let page = repoTableVC?.currentPage
        let table = PaginableTableView(frame: repoTableVC?.view.frame ?? CGRect.zero)
        let tablePage = table.firstPage
        table.loadData()
        
        XCTAssertNil(self.repos, "Delegate is Nil")
        XCTAssertEqual(repoTableVC?.view.backgroundColor, .white, "Background must be white")
        XCTAssertEqual(page, tablePage, "Starting pages must be equal - 1")
        XCTAssertNotNil(table, "TableView is Not Nil")

    }
    
    
    func testUtils(){
        let texHorBig = VisualFormat.fullHorBig
        let texVerSmall = VisualFormat.fullVerSmall
        let v = VisualFormat()
        
        let h = 150
        let w = 100
        let s = SizeHandler(size: CGSize(width: w, height: h))
        let sv = SizeHandler(view: UIView())
        let divided = s.frameDivided(In: 2, dimension: .height)
        let half = s.halfFrame(dimension: .height)
        let quarter = s.quarterFrame(dimension: .width)
        
        XCTAssertNotNil(v, "VisualFormat is Not Nil")
        XCTAssertEqual(VisualFormat.ajustableInCenterVer(top: 5, bottom: 5), "V:|-(>=5)-[v0]-(>=5)-|" , "Text must be for vertical - spaces: 5")
        XCTAssertEqual(VisualFormat.ajustableInCenterHor(left: 5, right: 5), "H:|-(>=5)-[v0]-(>=5)-|" , "Text must be for horizontal - spaces: 5")
        
        XCTAssertEqual(texHorBig, "H:|-16-[v0]-16-|", "Text must be for horizontal - space: 16")
        XCTAssertEqual(texVerSmall, "V:|-[v0]-|", "Text must be for vertical - space: default")
        
        XCTAssertEqual(s.width, 100, "Width must be 100")
        XCTAssertEqual(quarter, 25, "Width must be 25")
        XCTAssertEqual(divided, half, "Height divided must be 75")
        XCTAssertNotEqual(s.width, 80, "Width must Not be 80")
        XCTAssertEqual(sv.width, 0, "Width must be zero")
        XCTAssertEqual(sv.height, 0, "Height must be zero")
    }
    
    
    func testCells() {
        let rCell = RefreshingTableViewCell(style: .default, reuseIdentifier: RefreshingTableViewCell.identifier)
        let gCell = GitRepoTableViewCell(style: .default, reuseIdentifier: GitRepoTableViewCell.identifier)
        let l = rCell.loaderSign
        let photo = gCell.photo
        let stars = gCell.starsLabel.text
        
        XCTAssertEqual(rCell.accessibilityLabel, Project.Localizable.Accessiblity.loading.localized, "Refreshing has Accessiblity Label")
        XCTAssertEqual(l.color, .gitGray, "Loader color must be gray")
        XCTAssertNotNil(GitRepoTableViewCell.holderImage, "Holder Image must Not be Nil")
        XCTAssertNil(stars, "Label text must start as Nil")
        XCTAssertNotNil(photo.image, "Image must Not be Nil")

    }
    
    
    func testModels() {

        let imgStr = repos?.repositories.first?.owner?.avatarUrl ?? String()
        let imgView = UIImageView()
        imgView.imageFromURL(imgStr)
        
        let rMock = Repositories.Repositorie(name: "Test", owner: Repositories.Repositorie.Owner(id: 001, login: "test_log", avatarUrl: Project.url), starCount: 5)
        let serviceMocked = GitHubAPIService(totalCount: 1, items: [rMock])
        let repoMock = Repositories(from: serviceMocked)
        let nameMocked = repoMock.repositories.first?.name
        
        XCTAssertNotEqual(repos?.repositories.count, 1, "Repositories objects must Not be filled")
        XCTAssertNil(imgView.image, "Image in Service must be Nil")
        XCTAssertNotEqual(rMock.starCount, 0, "Stars Count in Mock must Not be zero")
        XCTAssertNotNil(serviceMocked, "service Mock must Not be Nil")
        XCTAssertNotNil(repoMock, "Repositories Mock object meust Not be Nil")
        XCTAssertEqual(rMock.name, nameMocked, "Names in Mocks must Not be equal")


    }


}

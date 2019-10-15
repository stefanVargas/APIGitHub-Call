//
//  ReposTableViewController.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 10/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class ReposTableViewController: UIViewController {

    //MARK: Atributes
    typealias VF = VisualFormat
    
    var repoTableView: PaginableTableView?
    
    var currentPage = 0
    var repoList: Repositories?
    
    
    // MARK: ReposTableViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.setupTableView()

    }

    
    // MARK: ReposTableViewController Setup Methods
    func setupView() {
        self.view.backgroundColor = .white
        
    }
    
    func setupTableView(){
        repoTableView = PaginableTableView()
        repoTableView?.paginableDataSource = self
        repoTableView?.paginableDelegate = self
        repoTableView?.allowsSelection = false
        repoTableView?.alwaysBounceVertical = true
        repoTableView?.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        repoTableView?.backgroundColor = .clear
        repoTableView?.separatorStyle = .singleLine
        repoTableView?.tintColor = .gitGray
        repoTableView?.enablePullToRefresh = true
        repoTableView?.loadData(refresh: true)
        repoTableView?.tableFooterView = UIView()
        self.currentPage = repoTableView?.currentPage ?? 0
        
        self.view.addSubview(repoTableView ?? UITableView())
        self.view.setupContraint(pattern: VF.fullVerDefault, views: repoTableView ?? UITableView())
        self.view.setupContraint(pattern: VF.fullHorTotal, views: repoTableView ?? UITableView())
        
    }

}


 // MARK: END ReposTableViewController to extensions
extension ReposTableViewController: PaginableTableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoList?.repositories.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: GitRepoTableViewCell.identifier, for: indexPath) as? GitRepoTableViewCell {
            cell.tag = indexPath.row
            
            cell.photo.image = nil
            
            if let imageUrl = self.repoList?.repositories[index].owner?.avatarUrl {
                cell.photo.imageFromURL(imageUrl)
                cell.photo.setRoundedCorners()
            }
            
            let nameText =  self.repoList?.repositories[index].name
            cell.repoNameLabel.text = nameText
            
            if let authorText = self.repoList?.repositories[index].owner?.login {
                cell.authorNameLabel.text =  Project.Localizable.Repo.author.localized + authorText
                
                cell.accessibilityLabel = Project.Localizable.Accessiblity.repository.localized + (nameText ?? String()) +  Project.Localizable.Repo.author.localized + authorText
            }
            
            if let starText = self.repoList?.repositories[index].starCount?.description {
                cell.starsLabel.text =  Project.Localizable.Repo.stars.localized + starText
                
                cell.accessibilityValue = Project.Localizable.Accessiblity.stars.localized + starText
            }
            
        
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension ReposTableViewController: PaginableTableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sizer = SizeHandler()
        let heightForRow = sizer.frameDivided(In: 6.25, dimension: .height)
        
        return heightForRow
    }
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
        var hasMore = false
        var data: Repositories?
        
        JsonParseUtil.fetchRepositoriesData(page: pageNumber) { result in
            
            if let service = try? result.get() {
                if pageNumber == 1 {
                    self.repoList = Repositories(from: service)
                    
                } else {
                    data = Repositories(from: service)
                    
                    for item in 0..<(pageSize) {
                        
                        guard let newRepository = data?.repositories[item] else { return }
                        self.repoList?.repositories.append(newRepository)
                    }
                    
                }
                hasMore = true
            }
            else {
                hasMore = false
                return
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            onSuccess?(hasMore)
            
        }
    }
}

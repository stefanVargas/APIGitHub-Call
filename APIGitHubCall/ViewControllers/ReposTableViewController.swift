//
//  ReposTableViewController.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 08/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

class ReposTableViewController: UIViewController {

    //MARK: Atributes
    typealias VF = VisualFormat
    
    var loadMoreViewHeight: CGFloat = 100
    var heightForHeaderInSection: CGFloat = 0


    private var repoTableView = PaginableTableView()
    var repoList: Repositories?

    
    // MARK: ReposTableViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    JsonParseUtil.fetchRepositoriesData(page: 0) { result in
            
        if let service = try? result.get() {
            self.repoList = Repositories(from: service)
        }
        else {
            
            self.view.backgroundColor = .red
            return
        }
            
        }
        
        self.setupView()
        self.setupTableView(table: self.repoTableView)
    }
    
    // MARK: ReposTableViewController Setup Methods
    func setupView() {
        self.view.backgroundColor = .white

        
    }
    
    func setupTableView(table:UITableView){
        
        table.dataSource = self
        table.delegate = self
        table.allowsSelection = false
        table.alwaysBounceVertical = true
        table.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.tintColor = .gitWhite
        
        self.view.addSubview(table)
        self.view.setupContraint(pattern: VF.fullVerTotal, views: table)
        self.view.setupContraint(pattern: VF.fullHorTotal, views: table)
        
    }
    
    
    // MARK: ReposTableViewController Auxiliar Methods
    
    private func calculateIndexPathsToReload(from newRepos: Repositories) -> [IndexPath] {
        let startIndex = (repoList?.repositories.count ?? 1) - newRepos.repositories.count
        let endIndex = startIndex + newRepos.repositories.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

// MARK: END ReposTableViewController to extensions

extension ReposTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return self.repoList?.repositories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let index = indexPath.row
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: GitRepoTableViewCell.identifier, for: indexPath) as? GitRepoTableViewCell {
            
            cell.photo = UIImageView(image: UIImage(named: Project.defaultImage))
            cell.repoNameLabel.text = self.repoList?.repositories[index].name
            cell.authorNameLabel.text = self.repoList?.repositories[index].owner?.login
            cell.starsLabel.text = self.repoList?.repositories[index].stargazers_count?.description
            
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == repoTableView.sections - 1 {
            let isRefreshing = repoTableView.refreshControl?.isRefreshing ?? false
            if !isRefreshing && repoTableView.isLoading {
                return loadMoreViewHeight
            }
            return 0.0
        }
        return repoTableView.estimatedRowHeight
    }
    
    
}

extension ReposTableViewController: PaginatedTableViewDelegate {
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
      
        if pageNumber == 1 { self.repoList?.repositories = [] }
        
        // TODO: Data to List
//        let startFrom = (self.list.last ?? 0) + 1
//        for repositorie in startFrom..<(startFrom + pageSize) {
//            self.list.append(number)
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            onSuccess?(true)
        }
    }
}

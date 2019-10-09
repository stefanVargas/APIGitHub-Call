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
    private var repoTableView = PaginableTableView()
    var repoList = [Repositorie]()

    
    // MARK: ReposTableViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .cyan
    }
    
    // MARK: ReposTableViewController Setup Methods
    
    
    func setupTableView(table:UITableView){
           
           table.dataSource = self
           table.delegate = self
           table.allowsSelection = false
           table.alwaysBounceVertical = true
           table.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
           table.backgroundColor = .clear
           table.separatorStyle = .singleLine
           table.tintColor = .gitWhite
        
       }
    
   
    // MARK: ReposTableViewController Auxiliar Methods


}

// MARK: END ReposTableViewController to extensions

extension ReposTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return self.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let index = indexPath.row
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: GitRepoTableViewCell.identifier, for: indexPath) as? GitRepoTableViewCell {
            
            cell.photo = UIImageView(image: UIImage(named: Project.defaultImage))
            cell.repoNameLabel.text = self.repoList[index].name
            cell.authorNameLabel.text = self.repoList[index].owner?.login
            cell.starsLabel.text = self.repoList[index].stargazers_count?.description
        }
        
        return UITableViewCell()
        
    }
    
    
}

extension ReposTableViewController: PaginatedTableViewDelegate {
    
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?) {
      
        if pageNumber == 1 { self.repoList = [Repositorie]() }
        
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

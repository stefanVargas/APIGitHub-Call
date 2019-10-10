//
//  PaginableTableView.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 09/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

 public protocol PaginatedTableViewDelegate: class {
   
    func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?)

}

class PaginableTableView: UITableView {
    
    //MARK: Infinite scrolling Atributes
    public var pageSize = 20
    private var hasMoreData = true
    private(set) var currentPage = 1
    private(set) var isLoading = false
    public var firstPage = 0
    
    //MARK: Refresh control Atributes
    lazy var refreshControltableView: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: Project.Localizable.Repo.refresh.localized)
        refreshControl.addTarget(self, action: #selector(self.startRefreshTableView(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    public var enablePullToRefresh = false {
        willSet {
            if newValue == enablePullToRefresh { return }
            if newValue {
                self.addSubview(refreshControltableView)
            } else {
                refreshControltableView.removeFromSuperview()
            }
        }
    }
    
    public var customReloadDataBlock: (() -> Void)?

    
    //MARK: Other Atributes
    let idForCell =  GitRepoTableViewCell.identifier
    var sections = 0

    weak open var paginatedDelegate: PaginatedTableViewDelegate?

    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        
        self.prefetchDataSource = self
        self.alwaysBounceVertical = true
        
        self.enablePullToRefresh = true
        
        self.register(GitRepoTableViewCell.self, forCellReuseIdentifier: idForCell)
    }
    
    // MARK: PaginableTableView Auxiliar Methods
    public func loadData(refresh: Bool = false) {
        load(refresh: refresh)
    }
    
    @objc fileprivate func startRefreshTableView(_ refreshControl: UIRefreshControl) {
        load(refresh: true)
    }
    
    func load(refresh: Bool = false) {
        
        if refresh {
            currentPage = firstPage
            hasMoreData = true
        }
        
        // return if already loading or dont have any more data
        if !hasMoreData || isLoading { return }
        
        // start loading
        isLoading = true
        paginatedDelegate?.loadMore(currentPage, pageSize, onSuccess: { hasMore in
            self.hasMoreData = hasMore
            self.currentPage += 1
            self.isLoading = false
            self.refreshControltableView.endRefreshing()
            if self.customReloadDataBlock != nil {
                self.customReloadDataBlock?()
            } else {
                self.reloadData()
            }
        }, onError: { _ in
            self.refreshControltableView.endRefreshing()
            self.isLoading = false
        })
    }

}

// MARK: END PaginableTableView to extensions

extension PaginableTableView: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: { $0.section == sections - 1 }) {
            load()
        }
    }
}

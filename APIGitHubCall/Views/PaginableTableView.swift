//
//  PaginableTableView.swift
//  APIGitHubCall
//
//  Created by Stefan V. de Moraes on 11/10/19.
//  Copyright © 2019 Stefan V. de Moraes. All rights reserved.
//

import UIKit

 @objc public protocol PaginableTableViewDelegate: class {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     @objc optional func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
     @objc optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
     @objc optional func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
     func loadMore(_ pageNumber: Int, _ pageSize: Int, onSuccess: ((Bool) -> Void)?, onError: ((Error) -> Void)?)
     @objc optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
 }

public protocol PaginableTableViewDataSource: class {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func numberOfSections(in tableView: UITableView) -> Int
}

class PaginableTableView: UITableView {
    
    //MARK: Infinite scrolling Atributes
    public var pageSize = 20
    private var hasMoreData = true
    private(set) var currentPage = 1
    private(set) var isLoading = false
    public var firstPage = 1
    
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
    var sections = 0
    var loadMoreViewHeight: CGFloat = 100
    var heightForHeaderInSection: CGFloat = 0
    public var headerTitle = String()

    /// Delegates
    weak open var paginableDelegate: PaginableTableViewDelegate?
    weak open var paginableDataSource: PaginableTableViewDataSource?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
    }
    
    private func setupTableView() {
        self.delegate = self
        self.dataSource = self
        self.prefetchDataSource = self
        self.alwaysBounceVertical = true
        self.register(RefreshingTableViewCell.self, forCellReuseIdentifier: RefreshingTableViewCell.identifier)
        self.register(GitRepoTableViewCell.self, forCellReuseIdentifier: GitRepoTableViewCell.identifier)

        self.enablePullToRefresh = true
        
    }
    
    // MARK: PaginableTableView Auxiliar Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            load()
        }
    }
    
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
        
        if !hasMoreData || isLoading { return }
        
        isLoading = true
        paginableDelegate?.loadMore(currentPage, pageSize, onSuccess: { hasMore in
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

extension PaginableTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
               if section == sections - 1 {

                   return 1
               } else {
                   return paginableDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == sections - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RefreshingTableViewCell.identifier, for: indexPath) as? RefreshingTableViewCell else { return UITableViewCell() }
            cell.loaderSign.hidesWhenStopped = true
            if self.isLoading {
                cell.loaderSign.startAnimating()
            } else {
                cell.loaderSign.stopAnimating()
            }
            return cell
        } else {
            return paginableDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
        }
    }
    
}

extension PaginableTableView: UITableViewDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        sections = 1
        
        if let numberOfSections = paginableDataSource?.numberOfSections(in: tableView) {
            sections += numberOfSections
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return paginableDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? estimatedRowHeight
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitle
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return paginableDelegate?.tableView?(tableView, heightForHeaderInSection: section) ?? heightForHeaderInSection
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == sections - 1 {
            let isRefreshing = refreshControl?.isRefreshing ?? false
            if !isRefreshing && self.isLoading {
                return loadMoreViewHeight
            }
            return 0.0
        }
        return paginableDelegate?.tableView(tableView, heightForRowAt: indexPath) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        paginableDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        paginableDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
}

//
//  TableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class TableViewController: UITableViewController {
    
    let searchController: UISearchController?
    
    public private(set) var sections: [Section]
    internal var searchDataSource: Datasource? {
        didSet {
            if let searchDataSource = searchDataSource {
                tableView.dataSource = searchDataSource
                tableView.reloadData()
            } else {
                tableView.dataSource = dataSource
                tableView.reloadData()
            }
        }
    }
    public var dataSource: Datasource {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    public init(style: UITableView.Style, sections: [Section], isSearchEnabled: Bool = true) {
        self.sections = sections
        self.dataSource = Datasource(sections: sections)
        if isSearchEnabled {
            searchController = UISearchController(searchResultsController: nil)
        } else {
            searchController = nil
        }
        super.init(style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.sections = []
        self.dataSource = Datasource(sections: [])
        searchController = nil
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        if let searchController = searchController {
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.sizeToFit()
            tableView.tableHeaderView = searchController.searchBar
            definesPresentationContext = true
        }
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController?.searchBar.resignFirstResponder()
    }
    
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = searchDataSource?.item(at: indexPath) ?? dataSource.item(at: indexPath)
        handleDidSelect(item, forItemAt: indexPath)
    }
    
    @discardableResult open func handleDidSelect(_ item: Section.Item, forItemAt indexPath: IndexPath) -> Bool {
        switch item {
        case .segue(let title, _, _, let viewController):
            guard let viewController = viewController?() else { return false }
            if viewController.title == nil {
                viewController.title = title
            }
            navigationController?.pushViewController(viewController, animated: true)
            return true
        case .action(_, _, _, let action):
            guard let action = action else { return false }
            action()
            if let selectedIndex = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndex, animated: true)
            }
            return true
        default: return false
        }
    }
}

extension TableViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let search = searchController.searchBar.text?.lowercased() ?? ""
        if search == "" {
            searchDataSource = nil
        } else {
            let filteredSections: [Section] = dataSource.sections.map({ section -> Section in
                let filteredItems = section.items.filter({ item -> Bool in
                    return item.matches(searchstring: search)
                })
                return Section(items: filteredItems, title: section.title, footer: section.footer)
            })
            searchDataSource = Datasource(sections: filteredSections)
        }
    }
}

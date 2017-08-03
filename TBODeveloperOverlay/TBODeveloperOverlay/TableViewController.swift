//
//  TableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class TableViewController: UITableViewController {
    
    public private(set) var sections: [Section]
    public var dataSource: Datasource {
        didSet {
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }
    
    public init(style: UITableViewStyle, sections: [Section]) {
        self.sections = sections
        self.dataSource = Datasource(sections: sections)
        super.init(style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.sections = []
        self.dataSource = Datasource(sections: [])
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        handleDidSelect(item)
    }
    
    @discardableResult open func handleDidSelect(_ item: Section.Item) -> Bool {
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

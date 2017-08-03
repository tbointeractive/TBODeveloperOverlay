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
    public private(set) var dataSource: Datasource
    
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
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}

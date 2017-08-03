//
//  SectionDatasource.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

public final class Datasource: NSObject, UITableViewDataSource {
    
    let sections: [Section]
    
    public init(sections: [Section]) {
        self.sections = sections
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.item(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier) ??
            UITableViewCell(style: .value1, reuseIdentifier: item.reuseIdentifier)
        
        switch item {
        case .info(let title, let detail):
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = detail
            cell.selectionStyle = .none
        case .segue(let title, let detail):
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = detail
            cell.accessoryType = .disclosureIndicator
        case .action(let title, let detail):
            cell.textLabel?.text = title
            cell.detailTextLabel?.text = detail
        }
        return cell
    }
    
    public func item(at indexPath: IndexPath) -> Section.Item {
        guard indexPath.section < sections.count else { fatalError("indexPath.section out of bounds")}
        guard indexPath.row < sections[indexPath.section].items.count else { fatalError("indexPath.row out of bounds")}
        return sections[indexPath.section].items[indexPath.row]
    }
    
}

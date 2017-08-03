//
//  UserDefaultsTableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class UserDefaultsTableViewController: TableViewController {
    static let defaultInspectors: [Inspector.Type] = []
    
    let readOnly: Bool
    let inspectors: [Inspector.Type]
    
    public init(style: UITableViewStyle, userDefauts: UserDefaults, readOnly: Bool = true, inspectors: [Inspector.Type]? = nil) {
        self.readOnly = readOnly
        self.inspectors = inspectors ?? UserDefaultsTableViewController.defaultInspectors
        super.init(style: style, sections: [Section.from(userDefauts)])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.readOnly = true
        self.inspectors = []
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    open func canEditItem(forKey key: String) -> Bool {
        return !readOnly
    }
    
    internal func inspector(key: String, value: Any, editable: Bool) -> UIViewController {
        var viewController: UIViewController? = nil
        for inspector in inspectors {
            viewController = inspector.inspector(for: value)
            if viewController != nil {
                break
            }
        }
        let inspector = viewController ?? ReadonlyFallbackInspector(inspectable: value)
        inspector.title = key
        
        return inspector
    }
    
}

extension UserDefaultsTableViewController {
    open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataSource.item(at: indexPath)
        switch item {
        case .segue(let title, _):
            guard let value = UserDefaults.standard.object(forKey: title) else { return }
            let canEdit = canEditItem(forKey: title)
            let viewController = inspector(key: title, value: value, editable: canEdit)
            navigationController?.pushViewController(viewController, animated: true)
        default: return
        }
    }
}



extension Section {
    static func from(_ userDefaults: UserDefaults, blacklist: [String] = []) -> Section {
        var items: [Item] = []
        for (key, value) in userDefaults.dictionaryRepresentation() {
            guard !blacklist.contains(key) else { continue }
            let item = Item.segue(title: key, detail: "\(value)")
            items.append(item)
        }
        return Section(items: items, title: "UserDefaults")
    }
}

extension UIViewController {
    class func inspector(key: String, value: Any, editable: Bool) -> UIViewController {
        let viewController = UIViewController()
        viewController.title = key
        viewController.view.backgroundColor = UIColor.white
        return viewController
    }
}

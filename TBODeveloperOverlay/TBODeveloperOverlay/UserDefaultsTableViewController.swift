//
//  UserDefaultsTableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class UserDefaultsTableViewController: TableViewController {
    static let defaultInspectors: [InspectorViewController.Type] = []
    static let defaultUserDefaultsKeysBlacklist: [String] = ["AppleLanguages", "AppleLocale", "AppleKeyboards", "AppleITunesStoreItemKinds", "AddingEmojiKeybordHandled", "ApplePasscodeKeyboards", "NSInterfaceStyle", "PKKeychainVersionKey", "AppleKeyboardsExpanded", "NSLanguages"]
    
    let canEdit: Bool
    let inspectors: [InspectorViewController.Type]
    let userDefaults: UserDefaults
    let blacklist: [String]
    let whitelist: [String]?
    
    public init(style: UITableViewStyle, userDefaults: UserDefaults, canEdit: Bool = true, inspectors: [InspectorViewController.Type]? = nil, userDefaultsKeysBlacklist: [String]? = nil, userDefaultsKeysWhitelist: [String]? = nil) {
        self.userDefaults = userDefaults
        self.blacklist = userDefaultsKeysBlacklist ?? UserDefaultsTableViewController.defaultUserDefaultsKeysBlacklist
        self.whitelist = userDefaultsKeysWhitelist
        self.canEdit = canEdit
        self.inspectors = inspectors ?? UserDefaultsTableViewController.defaultInspectors
        super.init(style: style, sections: [])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.canEdit = false
        self.blacklist = UserDefaultsTableViewController.defaultUserDefaultsKeysBlacklist
        self.whitelist = nil
        self.inspectors = []
        self.userDefaults = UserDefaults.standard
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let section = Section.from(userDefaults, blacklist: blacklist, whitelist: whitelist)
        self.dataSource = Datasource(sections: [section])
    }
    
    open func canEditItem(forKey key: String) -> Bool {
        return canEdit
    }
    
    @discardableResult open override func handleDidSelect(_ item: Section.Item) -> Bool {
        guard !super.handleDidSelect(item) else { return true }
        switch item {
        case .segue(let key, _, let identifier, _):
            guard let identifier = identifier,
                let value = userDefaults.object(forKey: identifier) else { return false }
            let canEdit = canEditItem(forKey: identifier)
            let viewController = inspector(key: identifier, value: value)
            if canEdit {
                viewController.didEdit = { [weak self] newValue in
                    self?.userDefaults.set(newValue, forKey: key)
                }
            }
            viewController.title = key
            navigationController?.pushViewController(viewController, animated: true)
            return true
        default: return false
        }
    }
    
    internal func inspector(key: String, value: Any) -> InspectorViewController {
        var viewController: InspectorViewController? = nil
        for inspector in inspectors {
            guard inspector.canInspect(value) else { break }
            viewController = inspector.init(coder: NSCoder())
            if viewController != nil {
                break
            }
        }
        let inspectorViewController = viewController ?? FallbackInspector.init(nibName: nil, bundle: nil)
        inspectorViewController.inspectable = value
        return inspectorViewController
    }
    
}

extension Section {
    static func from(_ userDefaults: UserDefaults, blacklist: [String]? = nil, whitelist: [String]? = nil) -> Section {
        var items: [Item] = []
        for (key, value) in userDefaults.dictionaryRepresentation() {
            if let whitelist = whitelist {
                guard whitelist.contains(key) else { continue }
            } else if let blacklist = blacklist {
                guard !blacklist.contains(key) else { continue }
            }
            let item = Item.segue(title: key, detail: "\(value)", identifier: key, viewController: nil)
            items.append(item)
        }
        return Section(items: items, title: "UserDefaults")
    }
}

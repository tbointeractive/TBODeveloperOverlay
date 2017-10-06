//
//  UserDefaultsTableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class UserDefaultsTableViewController: TableViewController {
    static let defaultUserDefaultsKeysBlacklist: [String] = ["AppleLanguages", "AppleLocale", "AppleKeyboards", "AppleITunesStoreItemKinds", "AddingEmojiKeybordHandled", "ApplePasscodeKeyboards", "NSInterfaceStyle", "PKKeychainVersionKey", "AppleKeyboardsExpanded", "NSLanguages", "AppleLanguagesDidMigrate"]
    
    let canEdit: Bool
    let inspectorCollection: InspectorCollection
    let userDefaults: UserDefaults
    let keys: [String]
    
    public convenience init(style: UITableViewStyle, userDefaults: UserDefaults, canEdit: Bool = false, inspectorCollection: InspectorCollection? = nil, userDefaultsKeysBlacklist: [String]? = nil, userDefaultsKeysWhitelist: [String]? = nil) {
        self.init(style: style, userDefaults: userDefaults, canEdit: canEdit, inspectorCollection: inspectorCollection) { key in
            if let whitelist = userDefaultsKeysWhitelist {
                return whitelist.contains(key)
            }
            let blacklist = userDefaultsKeysBlacklist ?? UserDefaultsTableViewController.defaultUserDefaultsKeysBlacklist
            return !blacklist.contains(key)
        }
    }
    
    public convenience init(style: UITableViewStyle, userDefaults: UserDefaults, canEdit: Bool = false, inspectorCollection: InspectorCollection? = nil, userDefaultsKeyFilter: (String)->(Bool)) {
        let keys = userDefaults.dictionaryRepresentation().keys.filter(userDefaultsKeyFilter)
        self.init(style: style, userDefaults: userDefaults, canEdit: canEdit, inspectorCollection: inspectorCollection, keys: Array(keys))
    }
    
    public init(style: UITableViewStyle, userDefaults: UserDefaults, canEdit: Bool = false, inspectorCollection: InspectorCollection? = nil, keys: [String]) {
        self.userDefaults = userDefaults
        self.keys = keys.sorted { $0.lowercased() < $1.lowercased() }
        self.canEdit = canEdit
        self.inspectorCollection = inspectorCollection ?? InspectorCollection.defaultCollection
        super.init(style: style, sections: [])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.canEdit = false
        self.keys = []
        self.inspectorCollection = InspectorCollection.defaultCollection
        self.userDefaults = UserDefaults.standard
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let section = Section.from(userDefaults, whitelist: keys)
        self.dataSource = Datasource(sections: [section])
    }
    
    open func canEditItem(forKey key: String) -> Bool {
        return canEdit
    }
    
    @discardableResult open override func handleDidSelect(_ item: Section.Item, forItemAt indexPath: IndexPath) -> Bool {
        guard !super.handleDidSelect(item, forItemAt: indexPath) else { return true }
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
        let viewController: InspectorViewController? = inspectorCollection.inspector(for: value)
        let inspectorViewController = viewController ?? FallbackInspectorViewController()
        inspectorViewController.inspectable = value
        return inspectorViewController
    }
    
}

extension Section {
    static func from(_ userDefaults: UserDefaults, whitelist: [String]) -> Section {
        var items: [Item] = []
        for key in whitelist {
            if let value = UserDefaults.standard.object(forKey: key) {
                let item = Item.segue(title: key, detail: "\(value)", identifier: key, viewController: nil)
                items.append(item)
            }
        }
        return Section(items: items, title: "UserDefaults")
    }
}

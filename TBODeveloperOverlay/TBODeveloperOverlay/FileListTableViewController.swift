//
//  FileListTableViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 04.08.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class FileListTableViewController: TableViewController {
    
    public init(style: UITableViewStyle, basePath: URL) {
        let fileManager = FileManager()
        let contents = try? fileManager.contentsOfDirectory(at: basePath, includingPropertiesForKeys: nil, options: [])
        super.init(style: style, sections: [Section.from(paths: contents ?? [], title: basePath.path)])
    }
    
    public init(style: UITableViewStyle, paths: [URL]) {
        super.init(style: style, sections: [Section.from(paths: paths)])
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var documentInteractionController: UIDocumentInteractionController?
    @discardableResult open override func handleDidSelect(_ item: Section.Item, forItemAt indexPath: IndexPath) -> Bool {
        guard !super.handleDidSelect(item, forItemAt: indexPath) else { return true }
        switch item {
        case .segue(_, _, let identifier, _):
            guard let path = identifier else { return false }
            let fileManager = FileManager()
            var isDirectory: ObjCBool = false
            if fileManager.fileExists(atPath: path, isDirectory: &isDirectory) {
                if isDirectory.boolValue {
                    let viewController = FileListTableViewController(style: .grouped, basePath: URL(fileURLWithPath: path))
                    navigationController?.pushViewController(viewController, animated: true)
                    return true
                } else {
                    guard let cell = tableView.cellForRow(at: indexPath) else { return false }
                    let controller = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
                    controller.delegate = self
                    controller.presentOptionsMenu(from: cell.frame, in: tableView, animated: true)
                    self.documentInteractionController = controller
                    return true
                }
            } else {
                return false
            }
        default: return false
        }
    }
}

extension FileListTableViewController: UIDocumentInteractionControllerDelegate {
    public func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

extension Section {
    static func from(paths: [URL], title: String = "Files and Folders") -> Section {
        let fileManager = FileManager()
        let bytecountFormatter = ByteCountFormatter()
        var items: [Item] = []
        for path in paths {
            let attributes = (try? fileManager.attributesOfItem(atPath: path.path)) ?? [:]
            let size = attributes[FileAttributeKey.size] as? Int64
            let modified = attributes[FileAttributeKey.modificationDate] as? Date
            let filesize = bytecountFormatter.string(fromByteCount: size ?? -1)
            let details = ["size: \(filesize)", "modified: \(modified as Any? ?? "unknown")"]
            let item = Item.segue(title: path.lastPathComponent, detail: details.joined(separator: ", "), identifier: path.path, viewController: nil)
            items.append(item)
        }
        return Section(items: items, title: title)
    }
}

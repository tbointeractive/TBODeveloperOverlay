//
//  FallbackInspector.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.08.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

final class FallbackInspectorViewController: InspectorViewController {
        
    private static func canEdit(_ inspectable: Any) -> Bool {
        if inspectable is String { return true }
        if inspectable is NSString {
            return true
        }
        return false
    }
    
    override class func canInspect(_ inspectable: Any) -> Bool {
        return true
    }
    
    let textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(textView)
        if let inspectable = inspectable {
            textView.text = "\(inspectable)"
        }
        if let inspectable = inspectable, didEdit != nil, FallbackInspectorViewController.canEdit(inspectable) {
            textView.isEditable = true
        } else {
            textView.isEditable = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = view.bounds.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if textView.isEditable {
            didEdit?(textView.text)
        }
    }
}

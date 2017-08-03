//
//  Inspector.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

public class InspectorViewController: UIViewController {
    
    var didEdit: ((_ newValue: Any) -> ())?
    
    var inspectable: Any? = nil
    
    class func canInspect(_ inspectable: Any) -> Bool {
        return false
    }
}

final class FallbackInspector: InspectorViewController {
    
    static let editableTypes: [Any.Type] = [String.self, NSString.self]
    
    private static func canEdit(_ inspectable: Any) -> Bool {
        if inspectable is String { return true }
        if let inspectable = inspectable as? NSString {
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
        if let inspectable = inspectable, didEdit != nil, FallbackInspector.canEdit(inspectable) {
            textView.isEditable = true
        } else {
            textView.isEditable = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if textView.isEditable {
            didEdit?(textView.text)
        }
    }
}

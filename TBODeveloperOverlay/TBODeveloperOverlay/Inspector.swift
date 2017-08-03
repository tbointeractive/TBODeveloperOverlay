//
//  Inspector.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

public protocol Inspector {
    static func inspector(for inspectable: Any) -> UIViewController?
}

final class ReadonlyFallbackInspector: UIViewController, Inspector {
    
    static func inspector(for inspectable: Any) -> UIViewController? {
        return ReadonlyFallbackInspector.init(inspectable: inspectable)
    }
    
    var didEdit: ((_ newValue: Any) -> ())?
    
    let inspectable: Any
    let textView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    
    init(inspectable: Any) {
        self.inspectable = inspectable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(textView)
        textView.text = "\(inspectable)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
}

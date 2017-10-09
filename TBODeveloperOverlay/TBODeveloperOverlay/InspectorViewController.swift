//
//  Inspector.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

public class InspectorViewController: UIViewController {
    
    public var didEdit: ((_ newValue: Any) -> ())?
    
    var inspectable: Any? = nil
    
    class func canInspect(_ inspectable: Any) -> Bool {
        return false
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

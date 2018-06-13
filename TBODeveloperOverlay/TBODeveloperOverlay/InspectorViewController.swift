//
//  Inspector.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 28.07.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

open class InspectorViewController: UIViewController {
    
    open var didEdit: ((_ newValue: Any) -> ())?
    
    open var inspectable: Any? = nil
    
    open class func canInspect(_ inspectable: Any) -> Bool {
        return false
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

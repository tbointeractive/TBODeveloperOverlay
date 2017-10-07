//
//  InspectorCollection.swift
//  TBODeveloperOverlay
//
//  Created by Pascal Stüdlein on 06.10.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

public class InspectorCollection {
    public static let defaultCollection: InspectorCollection = InspectorCollection(inspectors: [NumberInspectorViewController.self, BoolInspectorViewController.self])
    
    private let inspectors: [InspectorViewController.Type]
    
    public init(inspectors: [InspectorViewController.Type]) {
        self.inspectors = inspectors
    }
    
    public func inspector(for value: Any) -> InspectorViewController? {
        var viewController: InspectorViewController? = nil
        for inspector in inspectors {
            guard inspector.canInspect(value) else { continue }
            viewController = inspector.init()
            if viewController != nil {
                break
            }
        }
        
        viewController?.inspectable = value
        return viewController
    }
}

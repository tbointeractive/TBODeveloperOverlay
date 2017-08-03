//
//  BoolInspectorViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.08.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

final class BoolInspectorViewController: InspectorViewController {
    
    override class func canInspect(_ inspectable: Any) -> Bool {
        if String(validatingUTF8: object_getClassName(inspectable)) == "__NSCFBoolean" { return true }
        return false
    }
    
    let boolSwitch: UISwitch = {
        let boolSwitch = UISwitch(frame: .zero)
        boolSwitch.translatesAutoresizingMaskIntoConstraints = false
        return boolSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(boolSwitch)
        if let inspectable = inspectable {
            boolSwitch.isOn = inspectable as? Bool == true
        }
        boolSwitch.isUserInteractionEnabled = didEdit != nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boolSwitch.center = view.center
//        boolSwitch.frame = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let editedValue = self.editedValue() {
            didEdit?(editedValue)
        }
    }
    
    private func editedValue() -> Any? {
        return boolSwitch.isOn
    }
}

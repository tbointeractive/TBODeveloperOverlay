//
//  NumberInspectorViewController.swift
//  TBODeveloperOverlay
//
//  Created by Cornelius Horstmann on 03.08.17.
//  Copyright © 2017 TBO Interactive GmbH & CO KG. All rights reserved.
//

import Foundation

final class NumberInspectorViewController: InspectorViewController {
    
    override class func canInspect(_ inspectable: Any) -> Bool {
        if String(validatingUTF8: object_getClassName(inspectable)) == "__NSCFBoolean" { return false }
        if inspectable is NSNumber { return true }
        return false
    }
    
    let textField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(textField)
        if let inspectable = inspectable {
            textField.text = "\(inspectable)"
        }
        textField.isUserInteractionEnabled = didEdit != nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textField.frame = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let editedValue = self.editedValue() {
            didEdit?(editedValue)
        }
    }
    
    private func editedValue() -> Any? {
        guard let text = textField.text,
            let float = Float(text) else { return nil }
        return NSNumber(value: float)
    }
}

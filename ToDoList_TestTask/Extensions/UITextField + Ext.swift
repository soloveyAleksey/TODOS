//
//  UITextField + Ext.swift
//  ToDoList_TestTask

import UIKit

extension UITextField {
    
    convenience init(placeholder: String) {
        self.init()
        
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.autocorrectionType = .no
        self.clearButtonMode = .whileEditing
    }
}

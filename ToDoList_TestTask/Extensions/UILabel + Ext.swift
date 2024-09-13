//
//  UILabel + Ext.swift
//  ToDoList_TestTask

import UIKit

extension UILabel {
    
    convenience init(text: String) {
        self.init()
        
        self.text = text
        self.font = .systemFont(ofSize: 20, weight: .medium)
        self.textAlignment = .center
    }
}

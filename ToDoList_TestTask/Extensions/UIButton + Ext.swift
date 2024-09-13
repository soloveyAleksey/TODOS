//
//  UIButton + Ext.swift
//  ToDoList_TestTask

import UIKit

extension UIButton {
    
    convenience init(title: String) {
        self.init(type: .system)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 17)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 15
    }
    
    convenience init(imageName: String) {
        self.init(type: .system)
        
        let image = UIImage(systemName: imageName)
        self.setBackgroundImage(image, for: .normal)
        self.tintColor = .systemBlue
    }
}

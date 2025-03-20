//
//  TaskButton.swift
//  ToDoList_TestTask

import UIKit

final class TaskButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ title: String) {
        self.init(type: .system)
        
        configure(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .light)
    }
}

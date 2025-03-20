//
//  HeaderView.swift
//  ToDoList_TestTask

import UIKit

final class HeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let addTaskButton = UIButton(type: .system)
    private let allTaskButton = TaskButton("All")
    private let openTaskButton = TaskButton("Open")
    private let completedTaskButton = TaskButton("Completed")
    
    private lazy var labelStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
    private lazy var buttonStack = UIStackView(arrangedSubviews: [allTaskButton, openTaskButton, completedTaskButton])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubViews()
        createButtonAction()
        setupSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews() {
        titleLabel.text = "Today's Task"
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        
        let date = Date()
        dateLabel.text = date.headerDateToString
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 19)
        
        addTaskButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        addTaskButton.setTitle("+ New Task", for: .normal)
        addTaskButton.setTitleColor(.systemBlue, for: .normal)
        addTaskButton.layer.cornerRadius = 15
        
        labelStack.axis = .vertical
        
        buttonStack.axis = .horizontal
        buttonStack.distribution = .equalSpacing
        buttonStack.alignment = .leading
        buttonStack.spacing = 10
    }
    
    private func createButtonAction() {
        addTaskButton.addTarget(nil, action: #selector(ToDoListViewController.addTaskButtonAction), for: .touchUpInside)
        allTaskButton.addTarget(nil, action: #selector(ToDoListViewController.allTaskButtonAction), for: .touchUpInside)
        openTaskButton.addTarget(nil, action: #selector(ToDoListViewController.openTaskButtonAction), for: .touchUpInside)
        completedTaskButton.addTarget(nil, action: #selector(ToDoListViewController.completedTaskButtonAction), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        [labelStack, addTaskButton, buttonStack].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        [labelStack, addTaskButton, buttonStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: addTaskButton.leadingAnchor, constant: 10),
            
            addTaskButton.centerYAnchor.constraint(equalTo: labelStack.centerYAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40),
            
            buttonStack.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 10),
            buttonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

//
//  HeaderView.swift
//  ToDoList_TestTask

import UIKit

final class HeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let addTaskButton = UIButton(type: .system)
    
    private lazy var labelStack = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubViews()
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
        dateLabel.text = date.currentDateToString
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 19)
        
        addTaskButton.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        addTaskButton.setTitle("+ New Task", for: .normal)
        addTaskButton.setTitleColor(.systemBlue, for: .normal)
        addTaskButton.layer.cornerRadius = 15
        addTaskButton.addTarget(nil, action: #selector(ToDoListViewController.addTaskButtonAction), for: .touchUpInside)
        
        labelStack.axis = .vertical
    }
    
    private func setupSubviews() {
        addSubview(labelStack)
        addSubview(addTaskButton)
    }
    
    private func setConstraints() {
        [labelStack, addTaskButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: addTaskButton.leadingAnchor, constant: 10),
            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            addTaskButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addTaskButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            addTaskButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

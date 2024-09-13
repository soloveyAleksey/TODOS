//
//  ToDoCollectionViewCell.swift
//  ToDoList_TestTask

import UIKit

protocol ToDoCollectionCellDelegate: AnyObject {
    func doneButtonPressed(_ index: Int)
}

final class ToDoCollectionViewCell: UICollectionViewCell {
    static let identifire = "ToDoCollectionViewCell"
    
    weak var delegate: ToDoCollectionCellDelegate?
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateLabel = UILabel()
    private let doneButton = UIButton(type: .system)
    private let dividerView = UIView()
    
    private lazy var labelStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        configureSubviews()
        setupSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = 15
    }
    
    func setData(from todo: ToDoStorage, index: Int) {
        titleLabel.attributedText = todo.completed ? strikeText(strike: todo.todo) : NSAttributedString(string: todo.todo)
        
        descriptionLabel.text = todo.todoDescription ?? ""
        
        let date = Date()
        dateLabel.text = date.currentDateToString
        
        doneButton.tag = index
        if todo.completed {
            doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            doneButton.tintColor = .systemBlue
        } else {
            doneButton.setImage(UIImage(systemName: "circle"), for: .normal)
            doneButton.tintColor = .systemGray
        }
    }
    
    private func strikeText(strike : String) -> NSMutableAttributedString {
        
        let attributeString = NSMutableAttributedString(string: strike)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, attributeString.length))
        
        return attributeString
    }
    
    @objc private func doneButtonAction(_ sender: UIButton) {
        delegate?.doneButtonPressed(sender.tag)
    }
}

// MARK: - Configuration & Layout Subviews
private extension ToDoCollectionViewCell {
    
    func configureSubviews() {
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = .systemFont(ofSize: 17)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 17)
        
        doneButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        doneButton.tintColor = .systemBlue
        doneButton.layer.cornerRadius = frame.width / 2
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        
        dividerView.backgroundColor = .lightGray
        
        labelStack.axis = .vertical
        labelStack.spacing = 10
    }
    
    func setupSubviews() {
        [labelStack, doneButton, dividerView, dateLabel].forEach { addSubview($0) }
    }
    
    func setConstraints() {
        [labelStack, doneButton, dividerView, dateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(equalTo: doneButton.leadingAnchor, constant: 10),
            
            doneButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            doneButton.widthAnchor.constraint(equalToConstant: 60),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dividerView.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}

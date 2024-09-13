//
//  AddNewTaskViewController.swift
//  ToDoList_TestTask

import UIKit

protocol NewTaskViewProtocol: AnyObject {}

final class NewTaskViewController: UIViewController, NewTaskViewProtocol {
    
    var presenter: NewTaskPresenterProtocol!
    
    private let titleLabel = UILabel(text: "New Task")
    private let titleTaskTF = UITextField(placeholder: "Title Task")
    private let descrTaskTF = UITextField(placeholder: "Description")
    private let saveTaskButton = UIButton(title: "Save")
    private let backButton = UIButton(imageName: "arrow.uturn.backward")
    
    private lazy var vStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [titleTaskTF, descrTaskTF, saveTaskButton]))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        addButtonTarget()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func addButtonTarget() {
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        saveTaskButton.addTarget(self, action: #selector(saveTaskAction), for: .touchUpInside)
    }
    
    @objc private func backAction() {
        presenter.closeScreen()
    }
    
    @objc private func saveTaskAction() {
        guard let titleText = titleTaskTF.text,
              let descrText = descrTaskTF.text,
              titleText != ""
        else { return }
        
        presenter.createNewTask(titleText, descrText)
    }
}

// MARK: - Setup & Layout views
private extension NewTaskViewController {
    
    func setupViews() {
        view.backgroundColor = .systemGray5
        [backButton, titleLabel, vStack].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        [backButton, titleLabel, titleTaskTF, descrTaskTF, saveTaskButton, vStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleTaskTF.heightAnchor.constraint(equalToConstant: 45),
            titleTaskTF.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            descrTaskTF.heightAnchor.constraint(equalToConstant: 45),
            descrTaskTF.widthAnchor.constraint(equalTo: vStack.widthAnchor),
            
            saveTaskButton.heightAnchor.constraint(equalToConstant: 40),
            saveTaskButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

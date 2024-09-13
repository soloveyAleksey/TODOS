//
//  EditTaskViewController.swift
//  ToDoList_TestTask

import UIKit

protocol EditTaskViewProtocol: AnyObject {}

final class EditTaskViewController: UIViewController, EditTaskViewProtocol {
    
    var presenter: EditTaskPresenterProtocol!
    var task: ToDoStorage?
    
    let titleTaskTF = UITextField(placeholder: "Title Task")
    let descrTaskTF = UITextField(placeholder: "Description")
    private let titleLabel = UILabel(text: "Edit Task")
    private let saveEditButton = UIButton(title: "Save editing")
    private let backButton = UIButton(imageName: "arrow.uturn.backward")
    
    private lazy var vStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center
        return $0
    }(UIStackView(arrangedSubviews: [titleTaskTF, descrTaskTF, saveEditButton]))

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
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        saveEditButton.addTarget(self, action: #selector(editTaskAction), for: .touchUpInside)
    }
    
    @objc private func backButtonAction() {
        presenter.closeScreen()
    }
    
    @objc private func editTaskAction() {
        guard let task = task,
              let titleText = titleTaskTF.text,
              let descrText = descrTaskTF.text,
              titleText != ""
        else { return }
        
        presenter.changeTask(task, titleText, descrText)
    }
}

// MARK: - Setup & Layout views
private extension EditTaskViewController {
    
    func setupViews() {
        view.backgroundColor = .systemGray5
        [backButton, titleLabel, vStack].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        [backButton, titleLabel, titleTaskTF, descrTaskTF, saveEditButton, vStack].forEach {
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
            
            saveEditButton.heightAnchor.constraint(equalToConstant: 40),
            saveEditButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            vStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

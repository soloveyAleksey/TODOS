//
//  EditTaskInteractor.swift
//  ToDoList_TestTask

import Foundation

protocol EditTaskInteractorProtocol: AnyObject {
    func editTask(_ task: ToDoStorage, _ newTitle: String, _ newDescr: String?)
}

final class EditTaskInteractor {
    
    weak var presenter: EditTaskPresenterProtocol?
    private let storageManager = CoreDataManager.shared
}

extension EditTaskInteractor: EditTaskInteractorProtocol {
    
    func editTask(_ task: ToDoStorage, _ newTitle: String, _ newDescr: String?) {
        storageManager.editData(task, newTitle, newDescr)
        presenter?.closeScreen()
    }
}

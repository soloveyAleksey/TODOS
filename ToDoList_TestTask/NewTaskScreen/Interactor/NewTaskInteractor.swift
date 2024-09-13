//
//  NewTaskInteractor.swift
//  ToDoList_TestTask

import Foundation

protocol NewTaskInteractorProtocol: AnyObject {
    func addTask(_ title: String, _ descr: String?)
}

final class NewTaskInteractor {
    
    weak var presenter: NewTaskPresenterProtocol?
    private let storageManager = CoreDataManager.shared
}

extension NewTaskInteractor: NewTaskInteractorProtocol {
    
    func addTask(_ title: String, _ descr: String?) {
        let task = ToDoStorage(context: storageManager.viewContext)
        task.todo = title
        task.todoDescription = descr
        task.completed = false
        task.date = Date()
        
        storageManager.saveContext()
        presenter?.closeScreen()
    }
}

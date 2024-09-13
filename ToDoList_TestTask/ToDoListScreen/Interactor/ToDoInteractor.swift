//
//  ToDoInteractor.swift
//  ToDoList_TestTask

import Foundation

protocol ToDoInteractorProtocol: AnyObject {
    func getTaskList()
    func convertToStore(from todos: [TodoList]) 
    func obtainFromStorage() -> [ToDoStorage]
    func saveToStorage()
    func deleteFromStorage(_ task: ToDoStorage)
}

final class ToDoInteractor {
    
    weak var presenter: ToDoPresenterProtocol?
    
    private let networkService: NetworkServiceProtocol
    private let storageManager = CoreDataManager.shared
    private let todosUrl = "https://dummyjson.com/todos"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension ToDoInteractor: ToDoInteractorProtocol {
   
    func getTaskList() {
        networkService.getListTasks(from: todosUrl) { [weak self] result in
            self?.presenter?.getlist(tasks: result)
        }
    }
    
    func convertToStore(from todos: [TodoList]) {
        todos.forEach { todo in
            let store = ToDoStorage(context: storageManager.viewContext)
            store.todo = todo.todo
            store.completed = todo.completed
            store.date = Date()
            storageManager.saveContext()
        }
    }
    
    func obtainFromStorage() -> [ToDoStorage] {
        return storageManager.obtainSavedData()
    }
    
    func saveToStorage() {
        storageManager.saveContext()
    }
    
    func deleteFromStorage(_ task: ToDoStorage) {
        storageManager.delete(task)
    }
}

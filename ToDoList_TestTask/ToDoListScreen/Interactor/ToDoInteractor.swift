//
//  ToDoInteractor.swift
//  ToDoList_TestTask

import Foundation

protocol ToDoInteractorProtocol: AnyObject {
    func getTaskList()
    func convertToStorage(from todos: [TodoList])
    func fetchDataFromStorage() -> [ToDoStorage]
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
    
    func convertToStorage(from todos: [TodoList]) {
        storageManager.convertToStorage(from: todos)
    }
    
    func fetchDataFromStorage() -> [ToDoStorage] {
        storageManager.fetchData()
    }
    
    func saveToStorage() {
        storageManager.saveContext()
    }
    
    func deleteFromStorage(_ task: ToDoStorage) {
        storageManager.delete(task)
    }
}

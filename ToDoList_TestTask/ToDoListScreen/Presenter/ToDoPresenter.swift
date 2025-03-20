//
//  ToDoPresenter.swift
//  ToDoList_TestTask

import Foundation

enum FilterTask {
    case all
    case open
    case close
}

protocol ToDoPresenterProtocol: AnyObject {
    var toDoList: [ToDoStorage] { get set }
    var filteredTask: [ToDoStorage] { get set }
    func loadData()
    func getlist(tasks: Result<TaskList, Error>)
    func filterTasks(by type: FilterTask)
    func removeTask(at index: Int)
    func didButtonPressed(_ index: Int)
    func presentAddNewTask()
    func presentEditTask(_ index: Int)
}

final class ToDoPresenter {
    
    weak var view: ToDoListViewProtocol?
    var interactor: ToDoInteractorProtocol
    var router: ToDoRouterProtocol
    
    var toDoList = [ToDoStorage]()
    var filteredTask = [ToDoStorage]()
    
    init(view: ToDoListViewProtocol, interactor: ToDoInteractorProtocol, router: ToDoRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension ToDoPresenter: ToDoPresenterProtocol {
    
    func loadData() {
        if interactor.fetchDataFromStorage().isEmpty {
            view?.startActivityIndicator()
            interactor.getTaskList()
        } else {
            toDoList = interactor.fetchDataFromStorage()
            view?.updateView()
        }
    }
    
    func getlist(tasks: Result<TaskList, Error>) {
        switch tasks {
        case .success(let list):
            interactor.convertToStorage(from: list.todos)
            toDoList = interactor.fetchDataFromStorage()
            view?.updateView()
            view?.stopActivityIndicator()
        case .failure(let error):
            view?.showAlert(with: error.localizedDescription)
        }
    }
    
    func filterTasks(by type: FilterTask) {
        switch type {
        case .all:
            loadData()
            filteredTask = toDoList
        case .open:
            filteredTask = toDoList.filter { !$0.completed }
        case .close:
            filteredTask = toDoList.filter { $0.completed }
        }
        
        view?.updateView()
    }
    
    func removeTask(at index: Int) {
        let task = filteredTask.remove(at: index)
        view?.updateView()
        interactor.deleteFromStorage(task)
    }
    
    func didButtonPressed(_ index: Int) {
        toDoList[index].completed.toggle()
        view?.updateView()
        interactor.saveToStorage()
    }
    
    func presentAddNewTask() {
        router.presentNewTaskScreen()
    }
    
    func presentEditTask(_ index: Int) {
        let title = toDoList[index].todo
        let descr = toDoList[index].todoDescription
        router.presentEditTaskScreen(toDoList[index], title, descr)
    }
}

//
//  NewTaskPresenter.swift
//  ToDoList_TestTask

import Foundation

protocol NewTaskPresenterProtocol: AnyObject {
    func createNewTask(_ title: String, _ descr: String?)
    func closeScreen()
}

final class NewTaskPresenter {
    
    weak var view: NewTaskViewProtocol?
    var interactor: NewTaskInteractorProtocol
    var router: NewTaskRouterProtocol
    
    init(view: NewTaskViewProtocol, interactor: NewTaskInteractorProtocol, router: NewTaskRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewTaskPresenter: NewTaskPresenterProtocol {
    
    func createNewTask(_ title: String, _ descr: String?) {
        interactor.addTask(title, descr)
    }
    
    func closeScreen() {
        router.dismiss()
    }
}

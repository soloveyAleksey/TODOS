//
//  EditTaskPresenter.swift
//  ToDoList_TestTask

import Foundation

protocol EditTaskPresenterProtocol: AnyObject {
    func changeTask(_ task: ToDoStorage, _ title: String, _ descr: String?)
    func closeScreen()
}

final class EditTaskPresenter {
    
    weak var view: EditTaskViewController?
    var interactor: EditTaskInteractorProtocol
    var router: EditTaskRouter
    
    init(view: EditTaskViewController, interactor: EditTaskInteractorProtocol, router: EditTaskRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension EditTaskPresenter: EditTaskPresenterProtocol {
    
    func changeTask(_ task: ToDoStorage, _ title: String, _ descr: String?) {
        interactor.editTask(task, title, descr)
    }
    
    func closeScreen() {
        router.dismiss()
    }
}

//
//  AssemblyLayer.swift
//  ToDoList_TestTask

import Foundation

protocol AssemblyLayerProtocol: AnyObject {
    func createToDolistScreen() -> ToDoListViewController
    func createNewTaskScreen() -> NewTaskViewController
    func createEditTaskScreen() -> EditTaskViewController
}

final class AssemblyLayer: AssemblyLayerProtocol {
    func createToDolistScreen() -> ToDoListViewController {
        
        let view = ToDoListViewController()
        let networkService = NetworkService()
        let interactor = ToDoInteractor(networkService: networkService)
        let router = ToDoRouter()
        let presenter = ToDoPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func createNewTaskScreen() -> NewTaskViewController {
        
        let view = NewTaskViewController()
        let interactor = NewTaskInteractor()
        let router = NewTaskRouter()
        let presenter = NewTaskPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
    func createEditTaskScreen() -> EditTaskViewController {
        
        let view = EditTaskViewController()
        let interactor = EditTaskInteractor()
        let router = EditTaskRouter()
        let presenter = EditTaskPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}

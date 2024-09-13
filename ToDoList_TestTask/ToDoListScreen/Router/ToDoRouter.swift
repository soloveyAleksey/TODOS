//
//  ToDoRouter.swift
//  ToDoList_TestTask

import UIKit

protocol ToDoRouterProtocol: AnyObject {
    func presentNewTaskScreen()
    func presentEditTaskScreen(_ task: ToDoStorage, _ title: String, _ description: String?) 
}

final class ToDoRouter: ToDoRouterProtocol {
    
    weak var view: UIViewController?
    var assembly: AssemblyLayerProtocol = AssemblyLayer()
    
    func presentNewTaskScreen() {
        let controller = assembly.createNewTaskScreen()
        controller.modalPresentationStyle = .fullScreen
        view?.present(controller, animated: true)
    }
    
    func presentEditTaskScreen(_ task: ToDoStorage, _ title: String, _ description: String?) {
        let controller = assembly.createEditTaskScreen()
        controller.task = task
        controller.titleTaskTF.text = title
        controller.descrTaskTF.text = description
        controller.modalPresentationStyle = .fullScreen
        view?.present(controller, animated: true)
    }
}

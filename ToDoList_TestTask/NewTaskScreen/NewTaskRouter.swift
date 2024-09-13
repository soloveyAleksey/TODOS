//
//  NewTaskRouter.swift
//  ToDoList_TestTask

import UIKit

protocol NewTaskRouterProtocol: AnyObject {
    func dismiss()
}

final class NewTaskRouter: NewTaskRouterProtocol {
    weak var view: UIViewController?
    
    func dismiss() {
        view?.dismiss(animated: true)
    }
}

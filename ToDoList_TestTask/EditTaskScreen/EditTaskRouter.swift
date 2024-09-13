//
//  EditTaskRouter.swift
//  ToDoList_TestTask

import UIKit

protocol EditTaskRouterProtocol: AnyObject {
    func dismiss()
}

final class EditTaskRouter: EditTaskRouterProtocol {
    weak var view: UIViewController?
    
    func dismiss() {
        view?.dismiss(animated: true)
    }
}

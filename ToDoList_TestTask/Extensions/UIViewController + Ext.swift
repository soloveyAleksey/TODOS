//
//  UIViewController + Ext.swift
//  ToDoList_TestTask

import UIKit

extension UIViewController {
    
    func presentAlert(withError message: String) {
        let alertController = UIAlertController(
            title: "Received Error!",
            message: message.description,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
}

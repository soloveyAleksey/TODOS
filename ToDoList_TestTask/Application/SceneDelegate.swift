//
//  SceneDelegate.swift
//  ToDoList_TestTask

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var assembly: AssemblyLayerProtocol = AssemblyLayer()
    var storageManager = CoreDataManager.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = assembly.createToDolistScreen()
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        storageManager.saveContext()
    }
}


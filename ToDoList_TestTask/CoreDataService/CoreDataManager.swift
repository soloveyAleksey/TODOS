//
//  CoreDataManager.swift
//  ToDoList_TestTask

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoList_TestTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func editData(_ task: ToDoStorage, _ newTitle: String, _ newDescr: String?) {
        task.todo = newTitle
        task.todoDescription = newDescr
        task.completed = false
        task.date = Date()
        
        saveContext()
    }
    
    func obtainSavedData() -> [ToDoStorage] {
        let taskFetchRequest = ToDoStorage.fetchRequest()
        
        guard let result = try? viewContext.fetch(taskFetchRequest) else { return [] }
        return result
    }
    
    func delete(_ task: ToDoStorage) {
        viewContext.delete(task)
        saveContext()
    }
}

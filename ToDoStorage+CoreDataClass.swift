//
//  ToDoStorage+CoreDataClass.swift
//  ToDoList_TestTask

import Foundation
import CoreData

@objc(ToDoStorage)
public class ToDoStorage: NSManagedObject {}

extension ToDoStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoStorage> {
        return NSFetchRequest<ToDoStorage>(entityName: "ToDoStorage")
    }

    @NSManaged public var todo: String
    @NSManaged public var todoDescription: String?
    @NSManaged public var date: Date
    @NSManaged public var completed: Bool

}

extension ToDoStorage : Identifiable {}


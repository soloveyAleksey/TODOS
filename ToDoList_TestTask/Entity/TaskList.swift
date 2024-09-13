//
//  TaskList.swift
//  ToDoList_TestTask

import Foundation

struct TaskList: Decodable {
    let todos: [TodoList]
}

struct TodoList: Decodable {
    let todo: String
    let completed: Bool
}

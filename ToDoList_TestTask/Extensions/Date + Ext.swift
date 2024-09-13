//
//  Date + Ext.swift
//  ToDoList_TestTask

import Foundation

extension Date {
    
    var currentDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE dd MMMM")
        
        return dateFormatter.string(from: self)
    }
}

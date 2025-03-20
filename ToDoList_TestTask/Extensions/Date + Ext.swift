//
//  Date + Ext.swift
//  ToDoList_TestTask

import Foundation

extension Date {
    
    var headerDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM")
        
        return dateFormatter.string(from: self)
    }
    
    var currentDateToString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM, HH:mm")
        
        return dateFormatter.string(from: self)
    }
}

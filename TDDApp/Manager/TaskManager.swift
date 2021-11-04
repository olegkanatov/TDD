//
//  TaskManager.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 3.11.21.
//

import Foundation

class TaskManager {
    
    var tasksCount: Int {
        return tasks.count
    }
    var doneTasksCount: Int {
        return doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        
        tasks.append(task)
    }
    
    func task(at index: Int) -> Task {
        
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        
        let task = tasks.remove(at: index)
        doneTasks.append(task)
    }
    
    func doneTask(at index: Int) -> Task {
        
        return doneTasks[index]
    }
}

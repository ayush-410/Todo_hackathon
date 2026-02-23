//
//  TaskViewModel.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import Foundation
import Combine


final class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    init() {
        observeMidnightReset()
    }
    
    func getTasks(isCompleted:Bool = false) {
        
        let taskList = TaskStorage.shared.getTasks()
        tasks = taskList.filter({ task in
            task.isCompleted == isCompleted
        })
        
        if(hasActiveTasks()){
            NotificationManager.shared.scheduleNotification()
        } else {
            NotificationManager.shared.cancelNotification()
        }
    }
    
    func addTask(task: Task) -> Bool{
        
        let taskId = UUID()
        let newTask = Task(id: taskId, name: task.name, description: task.description, isCompleted: task.isCompleted, createdAt: task.createdAt)
        
        if (TaskStorage.shared.addTask(newTask)){
            return true
        }
        return false
    }
    
    func updateTask(updatedTask:Task) -> Bool {
        
        if(TaskStorage.shared.updateTask(updatedTask)){
            return true
        }
        return false
    }
    
    func deleteTask(task:Task) -> Bool {
        
        if(TaskStorage.shared.deleteTask(task: task)){
            return true
        }
        return false
    }
    
    private func observeMidnightReset() {
        NotificationCenter.default.addObserver(forName: .NSCalendarDayChanged, object: nil, queue: .main) { [weak self] _ in
            TaskStorage.shared.clearPrevTasks()
            self?.getTasks()
        }
    }
    
    private func hasActiveTasks() -> Bool {
        return tasks.contains { task in
            !task.isCompleted
        }
    }
}

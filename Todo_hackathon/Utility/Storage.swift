//
//  Storage.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 21/02/26.
//

import Foundation
final class TaskStorage {
    
    static let shared = TaskStorage()

    private let tasksKey = "TODAY_TASKS"
    private let dateKey  = "TASKS_DATE"

    private var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    func getTasks() -> [Task] {
        
        clearPrevTasks()

        guard let data = UserDefaults.standard.data(forKey: tasksKey),
              let tasks = try? JSONDecoder().decode([Task].self, from: data)
        else { return [] }

        return tasks
    }

    func addTask(_ task: Task) -> Bool {
        var tasks = getTasks()
        tasks.append(task)
        persist(tasks)
        return true
    }

    func updateTask(_ updatedTask: Task) -> Bool {
        var tasks = getTasks()

        guard let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) else { return false }
        tasks[index] = updatedTask

        persist(tasks)
        return true
    }

    func deleteTask(task: Task) -> Bool {
        var tasks = getTasks()
        if let index = tasks.firstIndex(where: { $0.id == task.id}){
            tasks.remove(at: index)
            persist(tasks)
            return true
        }
        return false
    }

    private func persist(_ tasks: [Task]) {
        let data = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(data, forKey: tasksKey)
        UserDefaults.standard.set(todayDate, forKey: dateKey)
    }

    func clearPrevTasks() {
        let savedDate = UserDefaults.standard.string(forKey: dateKey)

        if savedDate != todayDate {
            UserDefaults.standard.removeObject(forKey: tasksKey)
            UserDefaults.standard.set(todayDate, forKey: dateKey)
        }
    }
}

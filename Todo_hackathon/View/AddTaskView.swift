//
//  AddTaskView.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var showAddTaskView: Bool
    @State private var taskToAdd: Task = Task(id: UUID(), name: "", description: "", isCompleted: false, createdAt: Date())
    @Binding var refreshTaskList: Bool
    
    var body: some View {
        NavigationStack{
            List {
                Section {
                    TextField("Task name", text: $taskToAdd.name)
                    TextEditor(text: $taskToAdd.description)
                        .frame(minHeight: 30)
                } header: {
                    Text("Task Detail")
                }
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showAddTaskView.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if(taskViewModel.addTask(task: taskToAdd)){
                            showAddTaskView.toggle()
                            refreshTaskList.toggle()
                        }
                    } label: {
                        Text("Add")
                    }
                    .disabled(taskToAdd.name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(taskViewModel: TaskViewModel(), showAddTaskView: .constant(false), refreshTaskList: .constant(false))
}

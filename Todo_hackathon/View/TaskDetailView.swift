//
//  TaskDetailView.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @Binding var selectedTask: Task
    @Binding var showTaskDetailView: Bool
    @Binding var refreshTaskList: Bool
    
    var body: some View {
        NavigationStack {
            
            List {
                Section {
                    TextField("Task name", text: $selectedTask.name)
                    TextEditor(text: $selectedTask.description)
                        .frame(minHeight: 30)
                    Toggle(isOn: $selectedTask.isCompleted) {
                        Text("Mark Complete")
                    }
                } header: {
                    Text("Task Detail")
                }
                
                Section {
                    Button {
                        if (taskViewModel.deleteTask(task: selectedTask)) {
                            showTaskDetailView.toggle()
                            refreshTaskList.toggle()
                        }
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
            }
            .navigationTitle("Task Detail")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showTaskDetailView.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if (taskViewModel.updateTask(updatedTask: selectedTask)) {
                            showTaskDetailView.toggle()
                            refreshTaskList.toggle()
                        }
                    } label: {
                        Text("Update")
                    }
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(taskViewModel: TaskViewModel(), selectedTask: .constant(Task(id: UUID(), name: "Testing", description: "", isCompleted: false, createdAt: Date())), showTaskDetailView: .constant(false), refreshTaskList: .constant(false))
}

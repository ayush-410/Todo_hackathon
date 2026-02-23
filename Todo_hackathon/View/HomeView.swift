import SwiftUI

struct HomeView: View {
    
    @StateObject var taskViewModel = TaskViewModel()
    @State private var pickerSelection = "Active"
    @State private var taskFilters = ["Active", "Completed"]
    @State private var showAddTaskView: Bool = false
    @State private var showTaskDetailView: Bool = false
    @State private var selectedTask: Task = Task(id: UUID(), name: "", description: "",isCompleted: false, createdAt: Date())
    @State private var refreshTaskList: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        NavigationStack {
            VStack{
                
                Picker("Task Status", selection: $pickerSelection) {
                    ForEach(taskFilters, id:\.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: pickerSelection) { newValue in
                    taskViewModel.getTasks(isCompleted: newValue == "Completed")
                }
                
                if taskViewModel.tasks.isEmpty {
                    EmptyStateView(pickerSelection: $pickerSelection)
                } else {
                    List($taskViewModel.tasks, id:\.id){ $task in
                        TaskRowView(task: $task)
                            .onTapGesture {
                                showTaskDetailView = true
                                selectedTask = task
                            }
                    }
                }
            }
            .onAppear{
                taskViewModel.getTasks(isCompleted: pickerSelection == "Completed")
                NotificationManager.shared.requestAuthorization()
            }
            .onChange(of: refreshTaskList, perform: { _ in
                taskViewModel.getTasks(isCompleted: pickerSelection == "Completed")
            })
            .onChange(of: scenePhase, perform: { phase in
                if phase == .active {
                    NotificationManager.shared.resetBadgeCount()
                }
            })
            .navigationTitle("Today's ToDo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddTaskView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddTaskView) {
                AddTaskView(taskViewModel: taskViewModel, showAddTaskView: $showAddTaskView, refreshTaskList: $refreshTaskList)
            }
            .sheet(isPresented: $showTaskDetailView) {
                TaskDetailView(taskViewModel: taskViewModel, selectedTask: $selectedTask, showTaskDetailView: $showTaskDetailView, refreshTaskList: $refreshTaskList)
            }
        }
    }
}

#Preview {
    HomeView()
}

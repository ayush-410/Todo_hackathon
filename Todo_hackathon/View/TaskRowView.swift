//
//  TaskRowView.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import SwiftUI

struct TaskRowView: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(task.name)
                    .font(.title)
                
                HStack {
                    Text(task.description)
                        .lineLimit(1)
                        .font(.subheadline)
                    
                    Spacer()
                    
                    Text(task.createdAt.toString())
                        .font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    TaskRowView(task: .constant(Task(id: UUID(), name: "", description: "", isCompleted: false, createdAt: Date())))
}

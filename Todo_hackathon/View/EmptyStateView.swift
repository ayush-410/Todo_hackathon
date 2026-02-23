//
//  EmptyStateView.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 22/02/26.
//

import SwiftUI

struct EmptyStateView: View {
    
    @Binding var pickerSelection: String
    
    var isActive: Bool {
        pickerSelection == "Active"
    }
    
    var body: some View {
        VStack(spacing: 16) {
            
            Image(systemName: isActive ? "sunrise" : "checkmark.circle")
                .font(.system(size: 48))
                .foregroundStyle(.secondary)
            
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentTransition(.opacity)
        .animation(.easeInOut(duration: 0.25), value: pickerSelection)
    }
    
    var title: String {
        isActive ? "Nothing planned yet." : "Nothing completed yet."
    }
    
    var subtitle: String {
        isActive
        ? "Add something that matters today."
        : "Complete a task to see it here."
    }
}

#Preview {
    EmptyStateView(pickerSelection: .constant("Active"))
}

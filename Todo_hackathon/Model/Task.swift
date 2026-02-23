//
//  Task.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import Foundation

struct Task: Codable {
    let id: UUID
    var name: String
    var description: String
    var isCompleted: Bool
    var createdAt: Date
}

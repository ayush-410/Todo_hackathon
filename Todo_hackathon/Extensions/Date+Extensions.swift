//
//  Date+Extensions.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 20/02/26.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let result = dateFormatter.string(from: self)
        return result
    }
}

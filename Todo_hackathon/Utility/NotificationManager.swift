//
//  NotificationManager.swift
//  Todo_hackathon
//
//  Created by Ayush Kumar Singh on 22/02/26.
//

import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, _ in }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.subtitle = "Active Tasks will expire at Midnight"
        content.sound = .default
        content.badge = 1
        
        let reminderTime = Calendar.current.date(
            bySettingHour: 23 ,  // 11 PM
            minute: 0,
            second: 0,
            of: Date())!
        
        guard reminderTime > Date() else { return }
        
        let dateComponent: DateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func resetBadgeCount() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}

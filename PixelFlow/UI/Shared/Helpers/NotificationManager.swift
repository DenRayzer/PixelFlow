//
//  NotificationManager.swift
//  PixelFlow
//
//  Created by Елизавета on 06.06.2021.
//

import UserNotifications

class NotificationManager {
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                self.fetchNotificationSettings()
                completion(granted)
        }
    }

    func fetchNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                //         self.settings = settings
            }
        }
    }

    func scheduleNotification(notification: NotificationSetting, boardName: String) {
        let content = UNMutableNotificationContent()
        content.title = boardName
        content.body = "Gentle reminder for your task!"

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.hour, .minute],
                from: notification.time),
            repeats: true)

        let request = UNNotificationRequest(
            identifier: "\(boardName)-\(notification.time))",
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }

    func removeNotification(for ids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }

    func сonfigureId(for notification: NotificationSetting, boardName: String) -> String {
        return "\(boardName)-\(notification.time))"
    }
}

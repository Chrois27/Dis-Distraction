//
//  dis_distraction_mark3App.swift
//  dis-distraction.mark3
//
//  Created by Chris Choi on 2/8/24.
//

import SwiftUI
import UserNotifications

@main
struct dis_distraction_mark3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
    
    init() {
        NotificationManager.instance.requestAuthorization()
    }
}

class NotificationManager {
    static let instance = NotificationManager() // Singleton instance
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}


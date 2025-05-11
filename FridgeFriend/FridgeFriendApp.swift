//
//  FridgeFriendApp.swift
//  FridgeFriend
//
//  Created by Michael Eissen San Antonio on 5/10/25.
//

import SwiftUI

@main
struct FridgeFriendApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        NotificationManager.requestAuthorization()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

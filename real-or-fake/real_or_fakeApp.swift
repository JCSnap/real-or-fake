//
//  real_or_fakeApp.swift
//  real-or-fake
//
//  Created by Justin Cheah Yun Fei on 1/3/25.
//

import SwiftUI

@main
struct real_or_fakeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

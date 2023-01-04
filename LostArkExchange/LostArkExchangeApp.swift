//
//  LostArkExchangeApp.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import SwiftUI

@main
struct LostArkExchangeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

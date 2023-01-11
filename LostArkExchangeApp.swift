//
//  LostArkExchangeApp.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import SwiftUI

@main
struct LostArkExchangeApp: App {
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchEvent = EventAPI.shared
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear{
                    searchAuctionOptions.getMyIP()
                    searchEvent.getMyIP()
                }
        }
    }
}

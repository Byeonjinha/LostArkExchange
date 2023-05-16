//
//  LostArkExchangeApp.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import AdSupport
import AppTrackingTransparency
import GoogleMobileAds
import SwiftUI

@main
struct LostArkExchangeApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchEvent = EventAPI.shared
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            switch (NetworkReachability.isConnectedToNetwork(), searchEvent.serverError) {
            case (true, false):
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .task {
                        await searchAuctionOptions.getMyIP()
                        await searchEvent.getMyIP()
                    }
            case (_, true):
                ServerErrorView()
            default:
                DisconnectedNetWorkView()
            }
        }
    }
}

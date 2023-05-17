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
    @StateObject private var apiData = APIData.shared

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            switch (NetworkReachability.isConnectedToNetwork(), apiData.searchEvent.serverError) {
            case (true, false):
                MainView()
                    .environmentObject(apiData)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .task {
                        await apiData.searchAuctionOptions.getMyIP()
                        await apiData.searchEvent.getMyIP()
                    }
            case (_, true):
                ServerErrorView()
            default:
                DisconnectedNetWorkView()
            }
        }
    }
}

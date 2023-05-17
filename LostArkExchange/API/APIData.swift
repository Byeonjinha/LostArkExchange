//
//  APIData.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/17.
//

import Foundation
class APIData: ObservableObject {
    static let shared = APIData()
    @Published var searchAuctionOptions = AuctionOptionsAPI.shared
    @Published var searchEvent = EventAPI.shared
    
    private init() {}
}

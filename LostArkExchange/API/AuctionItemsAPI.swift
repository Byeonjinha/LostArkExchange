//
//  AuctionItemsAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import Foundation

class AuctionItemsAPI: ObservableObject {
    @Published var posts = [SearchItems]()
    static let shared = AuctionItemsAPI()
    private init() {
        
    }
    
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP(parameter: String) {
        let url = URL(string: "https://developer-lostark.game.onstove.com/auctions/items")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: String = parameter
        let data = parameters.data(using: .utf8)
        request.httpBody = data
        let header = ["Authorization" : "Bearer " + auth! ,
                      "Content-Type" : "application/json; charset=utf-8",
                      "'accept'" :  "'application/json'"
        ]
        
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard
                let data = data,
                error == nil
                    
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(SearchItems.self, from: data)
                DispatchQueue.main.async {
                    self.posts.append(apiResponse)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                print("dataCorrupted")
            } catch let DecodingError.keyNotFound(key, context) {
                print("키문제 '\(key)' not found:", context.debugDescription)
                print("코딩패스문제:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("값문제 '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("타입문제 '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
}

// MARK: - Welcome
struct SearchItems: Codable {
    let pageNo, pageSize, totalCount: Int?
    let items: [SearchItem]?
    
    enum CodingKeys: String, CodingKey {
        case pageNo = "PageNo"
        case pageSize = "PageSize"
        case totalCount = "TotalCount"
        case items = "Items"
    }
}

// MARK: - Item
struct SearchItem: Codable {
    let name, grade: String?
    let tier, level: Int?
    let icon: String?
    let gradeQuality: Int?
    let auctionInfo: AuctionInfo
    let options: [Option]
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case grade = "Grade"
        case tier = "Tier"
        case level = "Level"
        case icon = "Icon"
        case gradeQuality = "GradeQuality"
        case auctionInfo = "AuctionInfo"
        case options = "Options"
    }
}

// MARK: - AuctionInfo
struct AuctionInfo: Codable {
    let startPrice, buyPrice, bidPrice: Int?
    let endDate: String?
    let bidCount, bidStartPrice: Int?
    let isCompetitive: Bool?
    let tradeAllowCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case startPrice = "StartPrice"
        case buyPrice = "BuyPrice"
        case bidPrice = "BidPrice"
        case endDate = "EndDate"
        case bidCount = "BidCount"
        case bidStartPrice = "BidStartPrice"
        case isCompetitive = "IsCompetitive"
        case tradeAllowCount = "TradeAllowCount"
    }
}

// MARK: - Option
struct Option: Codable {
    let type, optionName, optionNameTripod: String?
    let value: Int?
    let isPenalty: Bool?
    let className: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case optionName = "OptionName"
        case optionNameTripod = "OptionNameTripod"
        case value = "Value"
        case isPenalty = "IsPenalty"
        case className = "ClassName"
    }
}

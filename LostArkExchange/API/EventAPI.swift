//
//  EventAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import Foundation

class EventAPI: ObservableObject {
    static let shared = EventAPI()
    @Published var serverNames: [(String,Int,Int)] = []
    @Published var worldIDs: [Int] = []
    @Published var posts = [Event]()
    @Published var serverError: Bool = false
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String

    func getMyIP() {
        let url = "https://developer-lostark.game.onstove.com/news/events"
        let header = ["Authorization" : "Bearer " + auth!]
        
        var urlComponents = URLComponents(string: url)
        
        let params = ["MaxItemLevel" : "1700"]

        var queryItems = [URLQueryItem]()
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComponents?.queryItems = queryItems

        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse else{
                return
            }
            
            switch response.statusCode {
            case 200:
                guard let data = data else{
                    return
                }
                do{
                    let apiResponse = try JSONDecoder().decode(Event.self, from: data)
                    self.posts.append(apiResponse)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
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
            case 503:
                DispatchQueue.main.async {
                    self.serverError = true
                }
            default:
                print("상태 코드:", response.statusCode)
            }
        }
        task.resume()
    }
}

// MARK: - EventElement
struct EventElement: Codable {
    let title: String
    let thumbnail: String
    let link: String
    let startDate, endDate: String
    let rewardDate: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case thumbnail = "Thumbnail"
        case link = "Link"
        case startDate = "StartDate"
        case endDate = "EndDate"
        case rewardDate = "RewardDate"
    }
}

typealias Event = [EventElement]

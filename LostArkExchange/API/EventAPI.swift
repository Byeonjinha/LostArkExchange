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
    private let auth = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyIsImtpZCI6IktYMk40TkRDSTJ5NTA5NWpjTWk5TllqY2lyZyJ9.eyJpc3MiOiJodHRwczovL2x1ZHkuZ2FtZS5vbnN0b3ZlLmNvbSIsImF1ZCI6Imh0dHBzOi8vbHVkeS5nYW1lLm9uc3RvdmUuY29tL3Jlc291cmNlcyIsImNsaWVudF9pZCI6IjEwMDAwMDAwMDAwNDYyMTgifQ.n6mPSL66p5GpwUx2wFtK_J0at50vXqRgp-J2aX0bOjWI6wzfwortAeLXmjPG0dMEpCZrpKLe3uKmLpgR4ExYVkjOZSst_Qa6JpiT7PYvnS007UK2W5IlarkDr07BFldsPOdIJ7knyrxPNasgbQPDTmyRA2u_SRJCJi8FzTaIiRcARl-_tWThiC5luaAYgg1hCPo32fCQEmJDszcRfp7xrlVmfVxWbotISL2ASW96D0ttO1p74DIkDkiJHHx9Xbk82R6CRepwvg0OCzqswET1Td_5Z0rcwjm5tKXIDHj3kNGBFA1qIN_fo1JMm5vO58uy5rVPIk3IAw1RTGK30QJLzg"
    func getMyIP() {
        let url = "https://developer-lostark.game.onstove.com/news/events"
        let header = ["Authorization" : "Bearer " + auth]
        
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
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                return
            }
            guard let data = data else{
                return
            }
            do{
                let apiResponse = try JSONDecoder().decode(Event.self, from: data)
                DispatchQueue.main.async {
                    self.posts.append(apiResponse)
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("키문제 '\(key)' not found:", context.debugDescription)
                print("코딩패스문제:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
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

// MARK: - WelcomeElement
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

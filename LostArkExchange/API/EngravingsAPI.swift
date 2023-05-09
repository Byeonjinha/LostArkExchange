//
//  EngravingsAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/26.
//

import Foundation

class EngravingsAPI: ObservableObject {
    
    static let shared = EngravingsAPI()

    @Published var posts: [String:EngravingDatas]? = [ : ]
    
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP(characterID: String) {
        let originalString = characterID
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "https://developer-lostark.game.onstove.com/armories/characters/\(escapedString!)/engravings"
        let header = ["Authorization" : "Bearer " + auth!]
        
        let urlComponents = URLComponents(string: url)

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
                let apiResponse = try JSONDecoder().decode(EngravingDatas?.self, from: data)
                DispatchQueue.main.async {
                    self.posts?[characterID] = apiResponse
                }
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

        }
        task.resume()
    }
}

// MARK: - Welcome
struct EngravingDatas: Codable {
    let engravings: [Engraving?]
    let effects: [Effect?]?

    enum CodingKeys: String, CodingKey {
        case engravings = "Engravings"
        case effects = "Effects"
    }
}

// MARK: - Effect
struct Effect: Codable {
    let name, description: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case description = "Description"
    }
}

// MARK: - Engraving
struct Engraving: Codable {
    let slot: Int?
    let name, icon, tooltip: String?

    enum CodingKeys: String, CodingKey {
        case slot = "Slot"
        case name = "Name"
        case icon = "Icon"
        case tooltip = "Tooltip"
    }
}

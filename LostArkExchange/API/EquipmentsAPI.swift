//
//  EquipmentsAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/20.
//

import Foundation

class EquipmentsAPI: ObservableObject {
    
    static let shared = EquipmentsAPI()

    @Published var posts: [String:Equipments]? = [ : ]
    
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP(characterID: String) {
        let originalString = characterID
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "https://developer-lostark.game.onstove.com/armories/characters/\(escapedString!)/equipment"
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
                let apiResponse = try JSONDecoder().decode(Equipments.self, from: data)
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

// MARK: - EquipmentsElement
struct EquipmentElement: Codable {
    let type, name, icon, grade: String?
    let tooltip: String?

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case name = "Name"
        case icon = "Icon"
        case grade = "Grade"
        case tooltip = "Tooltip"
    }
}

typealias Equipments = [EquipmentElement?]?


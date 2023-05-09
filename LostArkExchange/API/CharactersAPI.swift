//
//  CharactersAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/17.
//

import Foundation

class CharactersAPI: ObservableObject {
    
    static let shared = CharactersAPI()
    let searchCharacterProfile = CharacterProfileAPI.shared
    let searchCharacterEqupments = EquipmentsAPI.shared
    let searchCharacterEngravings = EngravingsAPI.shared
    
    @Published var posts = [Characters]() {
        didSet {
            if !posts.isEmpty {
                searchCharacterProfile.posts = [:]
                searchCharacterEqupments.posts = [:]
                searchCharacterEngravings.posts = [:]
                for characterProfiles in posts {
                    guard let characterProfiles = characterProfiles else {
                        return
                    }
                        for characterProfile in characterProfiles {
                            let characterName = characterProfile.characterName
                            searchCharacterProfile.getMyIP(characterID: characterName)
                            searchCharacterEqupments.getMyIP(characterID: characterName)
                            searchCharacterEngravings.getMyIP(characterID: characterName)
                    }
                }
            }
        }
    }
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP(characterID: String) {
        let originalString = characterID
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "https://developer-lostark.game.onstove.com/characters/\(escapedString!)/siblings"
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
                let apiResponse = try JSONDecoder().decode(Characters.self, from: data)
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

// MARK: - CharacterElement
struct CharacterElement: Codable {
    let serverName, characterName: String
    let characterLevel: Int
    let characterClassName, itemAvgLevel, itemMaxLevel: String?

    enum CodingKeys: String, CodingKey {
        case serverName = "ServerName"
        case characterName = "CharacterName"
        case characterLevel = "CharacterLevel"
        case characterClassName = "CharacterClassName"
        case itemAvgLevel = "ItemAvgLevel"
        case itemMaxLevel = "ItemMaxLevel"
    }
}

typealias Characters = [CharacterElement]?

//
//  CharacterProfileAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/18.
//


import Foundation

class CharacterProfileAPI: ObservableObject {
    
    static let shared = CharacterProfileAPI()

    @Published var posts: [String:CharacterProfile]? = [ : ]
    
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP(characterID: String) {
        let originalString = characterID
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = "https://developer-lostark.game.onstove.com/armories/characters/\(escapedString!)/profiles"
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
                let apiResponse = try JSONDecoder().decode(CharacterProfile.self, from: data)
                DispatchQueue.main.async {
                    self.posts?[apiResponse.characterName] = apiResponse
//                    print(apiResponse)x
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


// MARK: - CharacterProfile
struct CharacterProfile: Codable {
    let characterImage: String?
    let expeditionLevel: Int?
    let pvpGradeName: String?
    let townLevel: Int?
    let townName, title, guildMemberGrade, guildName: String?
    let usingSkillPoint, totalSkillPoint: Int?
    let stats: [Stat]?
    let tendencies: [Tendency]?
    let serverName, characterName: String
    let characterLevel: Int?
    let characterClassName, itemAvgLevel, itemMaxLevel: String?

    enum CodingKeys: String, CodingKey {
        case characterImage = "CharacterImage"
        case expeditionLevel = "ExpeditionLevel"
        case pvpGradeName = "PvpGradeName"
        case townLevel = "TownLevel"
        case townName = "TownName"
        case title = "Title"
        case guildMemberGrade = "GuildMemberGrade"
        case guildName = "GuildName"
        case usingSkillPoint = "UsingSkillPoint"
        case totalSkillPoint = "TotalSkillPoint"
        case stats = "Stats"
        case tendencies = "Tendencies"
        case serverName = "ServerName"
        case characterName = "CharacterName"
        case characterLevel = "CharacterLevel"
        case characterClassName = "CharacterClassName"
        case itemAvgLevel = "ItemAvgLevel"
        case itemMaxLevel = "ItemMaxLevel"
    }
}

// MARK: - Stat
struct Stat: Codable {
    let type, value: String
    let tooltip: [String]

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case value = "Value"
        case tooltip = "Tooltip"
    }
}

// MARK: - Tendency
struct Tendency: Codable {
    let type: String
    let point, maxPoint: Int

    enum CodingKeys: String, CodingKey {
        case type = "Type"
        case point = "Point"
        case maxPoint = "MaxPoint"
    }
}

//
//  AuctionOptionsAPI.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/05.
//

import Foundation

class AuctionOptionsAPI: ObservableObject {
    
    static let shared = AuctionOptionsAPI()
    
    @Published var posts = [Options]()
    
    @Published var maxLevel: Int?
    @Published var itemGradeQualities: [Int]?
    @Published var categories: [(Int, String)] = []
    @Published var itemGrades: [String]?
    @Published var itemTiers: [Int]?
    @Published var classes: [String]?
    @Published var skillOptionByCharacterClass: [SkillOptionsByCharacterClass] = []
    private let auth = Bundle.main.infoDictionary?["Auth"] as? String
    func getMyIP() {
        let url = "https://developer-lostark.game.onstove.com/auctions/options"
        let header = ["Authorization" : "Bearer " + auth!]
        
        var urlComponents = URLComponents(string: url)

        var queryItems = [URLQueryItem]()

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
                let apiResponse = try JSONDecoder().decode(Options.self, from: data)
                DispatchQueue.main.async {
                    self.maxLevel = apiResponse.maxItemLevel
                    self.itemGradeQualities = apiResponse.itemGradeQualities
                    for data in apiResponse.categories {
                        self.categories.append((data.code, data.codeName))
                        for subData in data.subs  {
                            self.categories.append((subData.code, subData.codeName))
                        }
                    }
                    self.itemGrades = apiResponse.itemGrades
                    self.itemTiers = apiResponse.itemTiers
                    self.classes = apiResponse.classes

                    for chrClass in self.classes! {
                        var skillOptions: [SkillOption] = []
                        for skillData in apiResponse.skillOptions {
                            if chrClass == skillData.skillOptionClass {
                                skillOptions.append(SkillOption(value: skillData.value, skillOptionClass: skillData.skillOptionClass, text: skillData.text, isSkillGroup: skillData.isSkillGroup, tripods: skillData.tripods))
                            }
                        }
                        self.skillOptionByCharacterClass.append(SkillOptionsByCharacterClass(characterClass: chrClass, skillOptions: skillOptions))
                    }
                    
                    for i in apiResponse.etcOptions {
                        var skill: (FirstOption, SecondOptions)?
                        skill?.0 = FirstOption(value: i.value, text: i.text)
                        skill?.1 = SecondOptions(secondOptions: [])
                        for j in  i.etcSubs {
                            skill?.1.secondOptions.append(SecondOption(value: j.value, text: j.text))

                        }
                    }
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

// MARK: - Options
struct Options: Codable {
    let maxItemLevel: Int
    let itemGradeQualities: [Int]
    let skillOptions: [SkillOption]
    let etcOptions: [EtcOption]
    let categories: [Category]
    let itemGrades: [String]
    let itemTiers: [Int]
    let classes: [String]

    enum CodingKeys: String, CodingKey {
        case maxItemLevel = "MaxItemLevel"
        case itemGradeQualities = "ItemGradeQualities"
        case skillOptions = "SkillOptions"
        case etcOptions = "EtcOptions"
        case categories = "Categories"
        case itemGrades = "ItemGrades"
        case itemTiers = "ItemTiers"
        case classes = "Classes"
    }
}

// MARK: - Category
struct Category: Codable {
    let subs: [Sub]
    let code: Int
    let codeName: String

    enum CodingKeys: String, CodingKey {
        case subs = "Subs"
        case code = "Code"
        case codeName = "CodeName"
    }
}

// MARK: - Sub
struct Sub: Codable {
    let code: Int
    let codeName: String

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case codeName = "CodeName"
    }
}

// MARK: - EtcOption
struct EtcOption: Codable {
    let value: Int
    let text: String
    let etcSubs: [EtcSub]

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case text = "Text"
        case etcSubs = "EtcSubs"
    }
}

// MARK: - EtcSub
struct EtcSub: Codable {
    let value: Int
    let text, etcSubClass: String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case text = "Text"
        case etcSubClass = "Class"
    }
}

// MARK: - SkillOption
struct SkillOption: Codable {
    let value: Int
    let skillOptionClass, text: String
    let isSkillGroup: Bool
    let tripods: [Tripod]

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case skillOptionClass = "Class"
        case text = "Text"
        case isSkillGroup = "IsSkillGroup"
        case tripods = "Tripods"
    }
}

// MARK: - Tripod
struct Tripod: Codable {
    let value: Int
    let text: String
    let isGem: Bool

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case text = "Text"
        case isGem = "IsGem"
    }
}

struct FirstOption {
    let value: Int
    let text: String
}

struct SecondOptions {
    var secondOptions: [SecondOption]
}

struct SecondOption {
    let value: Int
    let text: String
}

struct SkillOptionsByCharacterClass {
    let characterClass: String
    let skillOptions: [SkillOption]
}

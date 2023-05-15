//
//  MangnaniMethods.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import Foundation

func findEquipments(itemDatas: Equipments, itemArray: [String], itemType: Item) -> [[String]] {
    guard let itemDatas = itemDatas else {
        return []
    }
    var returnEquipmentsData: [[String]] = []
    for itemData in itemDatas {
        if itemArray.contains(itemData?.type ?? "") {
            var componentEquipmentsData: [String] = [itemData?.type ?? ""]
            componentEquipmentsData.append(itemData?.icon ?? "")
            componentEquipmentsData.append(itemData?.name ?? "")
            componentEquipmentsData.append(itemData?.grade ?? "")
            var parsedItemData = [String?]()
            switch itemType {
            case .equipment:
                parsedItemData = parseEquipmentsJSONString(jsonString: itemData?.tooltip)
            case .accessory:
                parsedItemData = parseAccessoriesJSONString(jsonString: itemData?.tooltip) ?? []
                if parsedItemData.isEmpty {
                    parsedItemData = parseAccessoriesJSONString2(jsonString: itemData?.tooltip) ?? []
                }
                if parsedItemData.isEmpty {
                    parsedItemData = parseAccessoriesJSONString3(jsonString: itemData?.tooltip) ?? []
                }
            case .abilitystone:
                parsedItemData = parseAbilityStoneJSONString1(jsonString: itemData?.tooltip) ?? []
                if parsedItemData.isEmpty {
                    parsedItemData = parseAbilityStoneJSONString2(jsonString: itemData?.tooltip) ?? []
                }
            case .bracelet:
                parsedItemData = parseBraceletJSONString(jsonString: itemData?.tooltip) ?? []
            case .engraving:
                parsedItemData = parseEngravingJSONString(jsonString: itemData?.tooltip) ?? []
            }
            
            for item in parsedItemData {
                if let unwrappedItem = item {
                    componentEquipmentsData.append(unwrappedItem)
                }
            }
            returnEquipmentsData.append(componentEquipmentsData)
        }
    }
    print(returnEquipmentsData)
    return returnEquipmentsData
}
func parseEquipmentsJSONString(jsonString: String?) -> [String?] {
    guard let data = jsonString?.data(using: .utf8) else { return [] }
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        
        let itemsObject000: [String: Any]? = json["Element_000"] as? [String: Any]
        let weaponse:String? = itemsObject000?["value"] as? String
        
        let itemsObject001: [String: Any]? = json["Element_001"] as? [String: Any]
        let items001Value: [String:Any]? = itemsObject001?["value"] as? [String:Any]
        let qualityValue: Int? = items001Value?["qualityValue"] as? Int
        let strQualityValue = String(qualityValue ?? 0)
        
        let itemsObject005: [String: Any]? = json["Element_005"] as? [String: Any]
        let items005Value: [String:Any]? = itemsObject005?["value"] as? [String:Any]
        let basicText: String?  = items005Value?["Element_000"] as? String
        let basicStat: String?  = items005Value?["Element_001"] as? String
        
        let itemsObject006: [String: Any]? = json["Element_006"] as? [String: Any]
        let items006Value: [String:Any]? = itemsObject006?["value"] as? [String:Any]
        let optionalText: String?  = items006Value?["Element_000"] as? String
        let optionalStat: String?  = items006Value?["Element_001"] as? String
        
        let parsedData: [String?] = [weaponse, strQualityValue, basicText, basicStat, optionalText, optionalStat]
        return parsedData
        
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

func parseAccessoriesJSONString(jsonString : String?) -> [String]? {
    
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    var weaponseColor = ""
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject006 = json["Element_006"] as? [String: AnyObject] else {
            return parsedData
        }
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items001Value = itemsObject001["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items005Value = itemsObject005["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items006Value = itemsObject006["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        
        
        guard let randomSealText = items006Value["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffects = randomSealText["contentStr"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffectText = randomSealText["topStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect1 = randomSealEffects["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect1Text = randomSealEffect1["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect2 = randomSealEffects["Element_001"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect2Text = randomSealEffect2["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect3 = randomSealEffects["Element_002"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect3Text = randomSealEffect3["contentStr"] as? String else {
            return parsedData
        }
        
        guard let optionalText = items005Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items005Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let itemquality = items001Value["qualityValue"] as? Int  else {
            return parsedData
        }
        
        let needData = [weaponseColor, optionalText, optionalStat, randomSealEffect1Text, randomSealEffect2Text, randomSealEffect3Text,  String(itemquality), randomSealEffectText]
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    
    return parsedData
}


func parseAccessoriesJSONString2(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    var weaponseColor = ""
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject006 = json["Element_006"] as? [String: AnyObject] else {
            return parsedData
        }
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items001Value = itemsObject001["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items005Value = itemsObject005["value"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let items006Value = itemsObject006["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealText = items006Value["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffects = randomSealText["contentStr"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffectText = randomSealText["topStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect1 = randomSealEffects["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect1Text = randomSealEffect1["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect2 = randomSealEffects["Element_001"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect2Text = randomSealEffect2["contentStr"] as? String else {
            return parsedData
        }
        
        guard let optionalText = items005Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items005Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let itemquality = items001Value["qualityValue"] as? Int  else {
            return parsedData
        }
        
        let needData = [weaponseColor, optionalText, optionalStat, randomSealEffect1Text, randomSealEffect2Text, "",  String(itemquality), randomSealEffectText]
        
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    
    return parsedData
}

func parseAccessoriesJSONString3(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    
    var weaponseColor = ""
    
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject006 = json["Element_006"] as? [String: AnyObject] else {
            return parsedData
        }
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items001Value = itemsObject001["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items005Value = itemsObject005["value"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let items006Value = itemsObject006["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealText = items006Value["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffects = randomSealText["contentStr"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffectText = randomSealText["topStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect1 = randomSealEffects["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect1Text = randomSealEffect1["contentStr"] as? String else {
            return parsedData
        }
        
        guard let optionalText = items005Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items005Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let itemquality = items001Value["qualityValue"] as? Int  else {
            return parsedData
        }
        
        let needData = [weaponseColor, optionalText, optionalStat, randomSealEffect1Text, "", "",  String(itemquality), randomSealEffectText]
        
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    
    return parsedData
}


func parseAbilityStoneJSONString1(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    var weaponseColor = ""
    
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject004 = json["Element_004"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject006 = json["Element_006"] as? [String: AnyObject] else {
            return parsedData
        }
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items001Value = itemsObject001["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items004Value = itemsObject004["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let basicStatText = items004Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let basicStat = items004Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let items005Value = itemsObject005["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let optionalStatText = items005Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items005Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let items006Value = itemsObject006["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealText = items006Value["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffects = randomSealText["contentStr"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffect1 = randomSealEffects["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect1Text = randomSealEffect1["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect2 = randomSealEffects["Element_001"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect2Text = randomSealEffect2["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect3 = randomSealEffects["Element_002"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect3Text = randomSealEffect3["contentStr"] as? String else {
            return parsedData
        }
        
        guard let itemquality = items001Value["qualityValue"] as? Int  else {
            return parsedData
        }
        
        let needData = [weaponseColor, basicStatText, basicStat, optionalStatText, optionalStat, randomSealEffect1Text, randomSealEffect2Text, randomSealEffect3Text, String(itemquality)]
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    return parsedData
}
func parseAbilityStoneJSONString2(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    var weaponseColor = ""
    
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject004 = json["Element_004"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items001Value = itemsObject001["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let items004Value = itemsObject004["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let basicStatText = items004Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let basicStat = items004Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let items005Value = itemsObject005["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealText = items005Value["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffects = randomSealText["contentStr"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let randomSealEffect1 = randomSealEffects["Element_000"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect1Text = randomSealEffect1["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect2 = randomSealEffects["Element_001"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect2Text = randomSealEffect2["contentStr"] as? String else {
            return parsedData
        }
        
        guard let randomSealEffect3 = randomSealEffects["Element_002"] as? [String:AnyObject] else {
            return parsedData
        }
        guard let randomSealEffect3Text = randomSealEffect3["contentStr"] as? String else {
            return parsedData
        }
        
        guard let itemquality = items001Value["qualityValue"] as? Int  else {
            return parsedData
        }
        
        let needData = [weaponseColor, basicStatText, basicStat, "", "", randomSealEffect1Text, randomSealEffect2Text, randomSealEffect3Text, String(itemquality)]
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    return parsedData
}

func parseBraceletJSONString(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    var weaponseColor = ""
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject000 = json["Element_000"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject004 = json["Element_004"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject005 = json["Element_005"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let items000Value = itemsObject000["value"] as? String else {
            return parsedData
        }
        if let rangeS = items000Value.range(of: fontText) {
            let weaponseIndex = items000Value.distance(from: items000Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items000Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let items004Value = itemsObject004["value"] as? [String:AnyObject] else {
            return parsedData
        }
        
        guard let canEnchantText = itemsObject005["value"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items004Value["Element_001"] as? String else {
            return parsedData
        }
        
        guard let optionalStatText = items004Value["Element_000"] as? String else {
            return parsedData
        }
        
        let needData = [weaponseColor, optionalStatText, optionalStat, canEnchantText]
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    return parsedData
}

func parseEngravingJSONString(jsonString : String?) -> [String]? {
    var parsedData = [String]()
    let fontText = "FONT COLOR="
    let fontEndText = "</FONT>"
    let engravingStartText = "각인 활성 포인트 "
    var engravingLevel = ""
    var weaponseColor = ""
    guard let data = (jsonString ?? "").data(using: .utf8) else {
        return nil
    }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let itemsObject001 = json["Element_001"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let items001Value = itemsObject001["value"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let engravingText = items001Value["leftText"] as? String else {
            return parsedData
        }
        if let rangeS = engravingText.range(of: engravingStartText) {
            if let rangeE = engravingText.range(of: fontEndText) {
                let startIndex = engravingText.distance(from: engravingText.startIndex, to: rangeS.lowerBound) + engravingStartText.count
                let endIndx = engravingText.distance(from: engravingText.startIndex, to: rangeE.lowerBound)
                engravingLevel = engravingText.substring(from: startIndex+1, to: endIndx - 1)
            }
        }
        
        guard let itemsObject002 = json["Element_002"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let items002Value = itemsObject002["value"] as? String else {
            return parsedData
        }
        if let rangeS = items002Value.range(of: fontText) {
            let weaponseIndex = items002Value.distance(from: items002Value.startIndex, to: rangeS.lowerBound) + fontText.count
            weaponseColor = items002Value.substring(from: weaponseIndex+1, to: weaponseIndex + 7)
        }
        
        guard let itemsObject003 = json["Element_003"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let items003Value = itemsObject003["value"] as? [String: AnyObject] else {
            return parsedData
        }
        
        guard let optionalText = items003Value["Element_000"] as? String else {
            return parsedData
        }
        
        guard let optionalStat = items003Value["Element_001"] as? String else {
            return parsedData
        }
        let needData = [weaponseColor, optionalText, optionalStat, engravingLevel]
        
        for data in needData {
            parsedData.append(data)
        }
    } catch {
        print("JSON 파싱 에러")
    }
    return parsedData
}

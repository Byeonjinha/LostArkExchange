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
                parsedItemData = parseAccessoriesJSONString(jsonString: itemData?.tooltip)
            case .abilitystone:
                parsedItemData = parseAbilityStoneJSONString(jsonString: itemData?.tooltip)
            case .bracelet:
                parsedItemData = parseBraceletJSONString(jsonString: itemData?.tooltip)
            }
            
            for item in parsedItemData {
                if let unwrappedItem = item {
                    componentEquipmentsData.append(unwrappedItem)
                } else {
                    componentEquipmentsData.append("")
                }
            }
            returnEquipmentsData.append(componentEquipmentsData)
        }
    }
    return returnEquipmentsData
}
func parseEquipmentsJSONString(jsonString: String?) -> [String?] {
    guard let data = jsonString?.data(using: .utf8) else { return [] }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        let itemsObject001: [String: Any]? = json["Element_001"] as? [String: Any]
        let items001Value: [String:Any]? = itemsObject001?["value"] as? [String: Any]
        let qualityValue: Int? = items001Value?["qualityValue"] as? Int
        let strQualityValue = String(qualityValue ?? 0)
        
        let itemsObject005: [String: Any]? = json["Element_005"] as? [String: Any]
        let items005Value: [String:Any]? = itemsObject005?["value"] as? [String: Any]
        let basicText: String?  = items005Value?["Element_000"] as? String
        let basicStat: String?  = items005Value?["Element_001"] as? String
        
        let itemsObject006: [String: Any]? = json["Element_006"] as? [String: Any]
        let items006Value: [String:Any]? = itemsObject006?["value"] as? [String: Any]
        let optionalText: String?  = items006Value?["Element_000"] as? String
        let optionalStat: String?  = items006Value?["Element_001"] as? String
        
        let parsedData: [String?] = [strQualityValue, basicText, basicStat, optionalText, optionalStat]
        return parsedData
        
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

func parseAccessoriesJSONString(jsonString : String?) -> [String?] {
    guard let data = (jsonString ?? "").data(using: .utf8) else { return [] }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        let itemsObject001 = json["Element_001"] as? [String: Any]
        let items001Value = itemsObject001?["value"] as? [String: Any]
        let qualityValue = items001Value?["qualityValue"] as? Int
        let strQualityValue = String(qualityValue ?? 0)
        
        let itemsObject005 = json["Element_005"] as? [String: Any]
        let items005Value = itemsObject005?["value"] as? [String: Any]
        let optionalText = items005Value?["Element_000"] as? String
        let optionalStat = items005Value?["Element_001"] as? String
        
        let itemsObject006 = json["Element_006"] as? [String: Any]
        let items006Value = itemsObject006?["value"] as? [String: Any]
        let randomSealText = items006Value?["Element_000"] as? [String:Any]
        
        let randomSealEffects = randomSealText?["contentStr"] as? [String: Any]
        let randomSealEffectText = randomSealText?["topStr"] as? String
        
        let randomSealEffect1 = randomSealEffects?["Element_000"] as? [String: Any]
        let randomSealEffect1Text = randomSealEffect1?["contentStr"] as? String
        let randomSealEffect2 = randomSealEffects?["Element_001"] as? [String: Any]
        let randomSealEffect2Text = randomSealEffect2?["contentStr"] as? String
        let randomSealEffect3 = randomSealEffects?["Element_002"] as? [String: Any]
        let randomSealEffect3Text = randomSealEffect3?["contentStr"] as? String
        return [strQualityValue, optionalText, optionalStat, randomSealEffect1Text, randomSealEffect2Text, randomSealEffect3Text, randomSealEffectText]
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

func parseBraceletJSONString(jsonString : String?) -> [String?] {
    guard let data = (jsonString ?? "").data(using: .utf8) else { return [] }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        let itemsObject004 = json["Element_004"] as? [String: Any]
        let items004Value = itemsObject004?["value"] as? [String:Any]
        let optionalStatText = items004Value?["Element_000"] as? String
        let optionalStat = items004Value?["Element_001"] as? String
        
        let itemsObject005 = json["Element_005"] as? [String: Any]
        let canEnchantText = itemsObject005?["value"] as? String
        return [optionalStatText, optionalStat, canEnchantText]
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

func parseAbilityStoneJSONString(jsonString : String?) -> [String?] {
    guard let data = (jsonString ?? "").data(using: .utf8) else { return [] }
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        
        let itemsObject001 = json["Element_001"] as? [String: Any]
        let items001Value = itemsObject001?["value"] as? [String:Any]
        let qualityValue = items001Value?["qualityValue"] as? Int
        let strQualityValue = String(qualityValue ?? 0)
        
        let itemsObject004 = json["Element_004"] as? [String: Any]
        let items004Value = itemsObject004?["value"] as? [String:Any]
        let basicStatText = items004Value?["Element_000"] as? String
        let basicStat = items004Value?["Element_001"] as? String
        
        let itemsObject005 = json["Element_005"] as? [String: Any]
        let items005Value = itemsObject005?["value"] as? [String:Any]
        let optionalStatText = items005Value?["Element_000"] as? String
        let optionalStat = items005Value?["Element_001"] as? String
        
        let itemsObject006 = json["Element_006"] as? [String: Any]
        let items006Value = itemsObject006?["value"] as? [String:Any]
        let randomSealText = items006Value?["Element_000"] as? [String:Any]
        let randomSealEffects = randomSealText?["contentStr"] as? [String:Any]
        let randomSealEffect1 = randomSealEffects?["Element_000"] as? [String:Any]
        let randomSealEffect1Text = randomSealEffect1?["contentStr"] as? String
        let randomSealEffect2 = randomSealEffects?["Element_001"] as? [String:Any]
        let randomSealEffect2Text = randomSealEffect2?["contentStr"] as? String
        let randomSealEffect3 = randomSealEffects?["Element_002"] as? [String:Any]
        let randomSealEffect3Text = randomSealEffect3?["contentStr"] as? String
        
        return [strQualityValue, basicStatText, basicStat, optionalStatText, optionalStat, randomSealEffect1Text, randomSealEffect2Text, randomSealEffect3Text]
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

func findEngravings(engravingDatas: [Engraving?]) -> [[String]] {
    var returnEquipmentsData: [[String]] = []
    for itemData in engravingDatas {
        var componentEquipmentsData: [String] = []
        componentEquipmentsData.append(itemData?.icon ?? "")
        componentEquipmentsData.append(itemData?.name ?? "")
        let parsedItemData = parseEngravingJSONString(jsonString: itemData?.tooltip)
        
        for item in parsedItemData {
            if let unwrappedItem = item {
                componentEquipmentsData.append(unwrappedItem)
            } else {
                componentEquipmentsData.append("")
            }
        }
        returnEquipmentsData.append(componentEquipmentsData)
    }
    return returnEquipmentsData
}
func parseEngravingJSONString(jsonString : String?) -> [String?] {
    guard let data = (jsonString ?? "").data(using: .utf8) else { return [] }
    let fontEndText = "</FONT>"
    let engravingStartText = "각인 활성 포인트 "
    var engravingLevel = ""
    do {
        guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return [] }
        
        let itemsObject001 = json["Element_001"] as? [String: Any]
        let items001Value = itemsObject001?["value"] as? [String: Any]
        let engravingText = items001Value?["leftText"] as? String
        
        let itemsObject003 = json["Element_003"] as? [String: Any]
        let items003Value = itemsObject003?["value"] as? [String: Any]
        let optionalText = items003Value?["Element_000"] as? String
        let optionalStat = items003Value?["Element_001"] as? String
        
        if let rangeS = engravingText?.range(of: engravingStartText) {
            if let rangeE = engravingText?.range(of: fontEndText) {
                let startIndex = (engravingText?.distance(from: engravingText!.startIndex, to: rangeS.lowerBound) ?? 0) + engravingStartText.count
                let endIndx = engravingText?.distance(from: engravingText!.startIndex, to: rangeE.lowerBound)
                engravingLevel = engravingText!.substring(from: startIndex+1, to: endIndx! - 1)
            }
        }
        return [optionalText, optionalStat, engravingLevel]
    } catch {
        print("JSON 파싱 에러")
        return []
    }
}

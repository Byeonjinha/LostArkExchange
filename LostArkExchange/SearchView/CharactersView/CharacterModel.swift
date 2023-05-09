//
//  CharacterModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct EquipmentViewData {
    var name: String
    var image: String
    var quality: String
    var basicStat: String
    var basicText: String
    var optionStat: String
    var optionText: String
    var color: String
    var qualityColor: Color
}

struct EngravingViewData {
    var name: String
    var image: String
    var color: String
    var description: String
    var level: String
    var text: String
}


struct AccessoriesViewData {
    var name: String
    var image: String
    var color: String
    var optionalText: String
    var optionalStat: String
    var randomEffect1: String
    var randomEffect2: String
    var randomEffect3: String
    var quality: String
    var qualityColor: Color
    var randomEffectText: String
}

struct BraceletViewData {
    var name: String
    var image: String
    var color: String
    var statText: String
    var optionalStat: String
    var enchantText: String
}

struct AbilitystoneViewData {
    var name: String
    var image: String
    var color: String
    var basicText: String
    var basicStat: String
    var optionText: String
    var optionStat: String
    var option1Text: String
    var option2Text: String
    var option3Text: String
    var quality: String
    var qualityColor: Color
}

struct Tooltip: Codable {
    let name: String
    let itemType: String
    let quality: Int
    let isEquipped: Bool
    let tradeRestriction: String
    let basicStats: [String: Int]
    let additionalStats: [String: Int]
    let randomEnchant: String
    let destroyRestriction: Bool
    let upgradeRestriction: Bool
    
    enum CodingKeys: String, CodingKey {
        case name = "Element_000"
        case itemType = "Element_001"
        case quality = "Element_001.value.qualityValue"
        case isEquipped = "Element_001.value.rightStr0"
        case tradeRestriction = "Element_003.value"
        case basicStats = "Element_004.value"
        case additionalStats = "Element_005.value"
        case randomEnchant = "Element_006.value.Element_000.contentStr.Element_000.contentStr"
        case destroyRestriction = "Element_007.value.contains(\"파괴불가\")"
        case upgradeRestriction = "Element_007.value.contains(\"품질 업그레이드 불가\")"
    }
}

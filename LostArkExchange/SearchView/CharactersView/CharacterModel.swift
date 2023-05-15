//
//  CharacterModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI


struct EquipmentViewData {
    var type: String
    var name: String
    var image: String
    var quality: String
    var basicStat: String
    var basicText: String
    var optionStat: String
    var optionText: String
    var grade: String
    var qualityColor: Color
    var gradeColor: Color
}

struct AccessoriesViewData {
    var type: String
    var name: String
    var image: String
    var quality: String
    var optionalText: String
    var optionalStat: String
    var randomEffect1: String
    var randomEffect2: String
    var randomEffect3: String
    var randomEffectText: String
    var gradeColor: Color
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

enum Item {
    case equipment
    case bracelet
    case accessory
    case abilitystone
    case engraving
}



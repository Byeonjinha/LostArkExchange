//
//  CharacterViewModel  .swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI
class CharacterViewModel: ObservableObject{
    var equipmentsArray: [String] = ["무기", "어깨", "투구", "상의", "하의", "장갑"]
    var braceletArray: [String] = ["팔찌"]
    var accessoriesArray: [String] = ["반지", "귀걸이", "목걸이"]
    var abilitystoneArray: [String] = ["어빌리티 스톤"]
    var engravingArray: [String] = ["각인"]
    
    @Published var equipment: EquipmentViewData = EquipmentViewData(name: "",
                                                                image: "",
                                                                quality: "",
                                                                basicStat: "",
                                                                basicText: "",
                                                                optionStat: "",
                                                                optionText: "",
                                                                color: "",
                                                                qualityColor: .white)
    
    @Published var engraving: EngravingViewData = EngravingViewData(name: "",
                                                                image: "",
                                                                color: "",
                                                                description: "",
                                                                level: "",
                                                                text: "")
    
    @Published var accessories: AccessoriesViewData = AccessoriesViewData(name: "",
                                                                      image: "",
                                                                      color: "",
                                                                      optionalText: "",
                                                                      optionalStat: "",
                                                                      randomEffect1: "",
                                                                      randomEffect2: "",
                                                                      randomEffect3: "",
                                                                      quality: "",
                                                                      qualityColor: .white,
                                                                      randomEffectText: "")
    
    @Published var bracelet: BraceletViewData = BraceletViewData(name: "",
                                                             image: "",
                                                             color: "",
                                                             statText: "",
                                                             optionalStat: "",
                                                             enchantText: "")
    
    
    @Published var abilitystone: AbilitystoneViewData = AbilitystoneViewData(name: "",
                                                                         image: "",
                                                                         color: "",
                                                                         basicText: "",
                                                                         basicStat: "",
                                                                         optionText: "",
                                                                         optionStat: "",
                                                                         option1Text: "",
                                                                         option2Text: "",
                                                                         option3Text: "",
                                                                         quality: "",
                                                                         qualityColor: .white)
    
    @Published var isEquipmentsViewStatus: Int = 0
}

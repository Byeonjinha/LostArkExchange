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
    
    @Published var equipment: EquipmentViewData = EquipmentViewData(type: "",
                                                                    name: "",
                                                                    image: "",
                                                                    quality: "",
                                                                    basicStat: "",
                                                                    basicText: "",
                                                                    optionStat: "",
                                                                    optionText: "",
                                                                    grade: "",
                                                                    qualityColor: .white,
                                                                    gradeColor: .white)
    
    @Published var engraving: EngravingViewData = EngravingViewData(name: "",
                                                                    image: "",
                                                                    description: "",
                                                                    level: "",
                                                                    text: "")
    
    @Published var accessories: AccessoriesViewData = AccessoriesViewData(type: "",
                                                                          name: "",
                                                                          image: "",
                                                                          quality: "",
                                                                          optionalText: "",
                                                                          optionalStat: "",
                                                                          randomEffect1: "",
                                                                          randomEffect2: "",
                                                                          randomEffect3: "",
                                                                          randomEffectText: "",
                                                                          gradeColor: .white,
                                                                          qualityColor: .white)
    
    @Published var bracelet: BraceletViewData = BraceletViewData(type: "",
                                                                 name: "",
                                                                 image: "",
                                                                 statText: "",
                                                                 optionalStat: "",
                                                                 enchantText: "",
                                                                 gradeColor: .white)
    
    
    @Published var abilitystone: AbilitystoneViewData = AbilitystoneViewData(type:"",
                                                                             name: "",
                                                                             image: "",
                                                                             basicText: "",
                                                                             basicStat: "",
                                                                             optionText: "",
                                                                             optionStat: "",
                                                                             option1Text: "",
                                                                             option2Text: "",
                                                                             option3Text: "",
                                                                             quality: "",
                                                                             qualityColor: .white,
                                                                             gradeColor: .white)
    
    @Published var isEquipmentsViewStatus: Int = 0
}



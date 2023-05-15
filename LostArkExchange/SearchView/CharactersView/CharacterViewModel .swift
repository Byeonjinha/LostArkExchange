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
                                                                    color: "",
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


func makeEquipments(element: [String]) -> EquipmentViewData {
    var data:EquipmentViewData = EquipmentViewData(type: element[0],
                                                   name: element[2],
                                                   image: element[1],
                                                   quality: element[5],
                                                   basicStat: element[7],
                                                   basicText: element[6],
                                                   optionStat: "",
                                                   optionText: "",
                                                   grade: element[3],
                                                   qualityColor: findItemQualityColor(quaility: Int(element[5]) ?? 0),
                                                   gradeColor: findItemGradeColor(grade: element[3])
    )
    if element.count > 8{
        data = EquipmentViewData(type: element[0],
                                 name: element[2],
                                 image: element[1],
                                 quality: element[4],
                                 basicStat: element[6],
                                 basicText: element[5],
                                 optionStat: element[8],
                                 optionText: element[7],
                                 grade: element[3],
                                 qualityColor: findItemQualityColor(quaility: Int(element[4]) ?? 0),
                                 gradeColor: findItemGradeColor(grade: element[3])
        )
    }
    return data
}


func makeAccessories(element: [String]) -> AccessoriesViewData {
    let data:AccessoriesViewData = AccessoriesViewData(type: element[0],
                                                       name: element[2],
                                                       image: element[1],
                                                       quality: element[4],
                                                       optionalText: element[5],
                                                       optionalStat: element[6],
                                                       randomEffect1: element[7],
                                                       randomEffect2: element[8],
                                                       randomEffect3: element[9],
                                                       randomEffectText: element[10],
                                                       gradeColor: findItemGradeColor(grade: element[3]),
                                                       qualityColor: findItemQualityColor(quaility: Int(element[4]) ?? 0))
    return data
}

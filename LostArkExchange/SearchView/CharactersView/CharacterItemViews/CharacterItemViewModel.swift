//
//  CharacterItemViewModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/15.
//
import Foundation
class CharacterItemViewModel: ObservableObject {
    func makeEquipments(element: [String]) -> EquipmentViewData {
        let data = EquipmentViewData(type: element[0],
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

    func makeBracelet(element: [String]) -> BraceletViewData {
        let data: BraceletViewData = BraceletViewData(type: element[0],
                                                     name: element[2],
                                                     image: element[1],
                                                     statText: element[4],
                                                     optionalStat: element[5],
                                                     enchantText: element[6],
                                                     gradeColor: findItemGradeColor(grade: element[3]))
        return data
    }
    
    func makeAbilitystone(element: [String]) -> AbilitystoneViewData {
        let data: AbilitystoneViewData = AbilitystoneViewData(type: element[0],
                                                              name: element[2],
                                                              image: element[1],
                                                              basicText: element[5],
                                                              basicStat: element[6],
                                                              optionText: element[7],
                                                              optionStat: element[8],
                                                              option1Text: element[9],
                                                              option2Text: element[10],
                                                              option3Text: element[11],
                                                              quality: element[4],
                                                              qualityColor: findItemQualityColor(quaility: Int(element[4]) ?? 0),
                                                              gradeColor: findItemGradeColor(grade: element[3]))
        return data
    }
    
    func makeEngraving(element: [String]) -> EngravingViewData {
        let data: EngravingViewData = EngravingViewData(name: element[1],
                                                        image: element[0],
                                                        description: element[3],
                                                        level: element[4],
                                                        text: element[2])
        return data
    }
}

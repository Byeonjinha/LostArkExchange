//
//  CharacterDetailEquipmentsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct CharacterDetailEquipmentsView: View {
    @StateObject var vm = CharacterViewModel()
    @StateObject private var searchCharacterEqupments = EquipmentsAPI.shared
    @StateObject private var searchCharacterEngraings = EngravingsAPI.shared
    let characterName: String
    
    var body: some View {
        if let searchCharacterEqupments = searchCharacterEqupments.posts?[characterName]{
            let findEquipmentElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.equipmentsArray, itemType: Item.equipment)
            let findAccessoriesElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.accessoriesArray, itemType: Item.accessory)
            let findAbilitystoneElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.abilitystoneArray, itemType: Item.abilitystone)
            let findBraceletElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.braceletArray, itemType: Item.bracelet)
            let findEngravingsElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.engravingArray, itemType: Item.engraving)
        
        if vm.isEquipmentsViewStatus == 0 {
            HStack {
                VStack(alignment: .leading) {
                    CharacterEquipmentsView(findEquipmentElements: findEquipmentElements,
                                            equipmentsArray: vm.equipmentsArray,
                                            isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                            equipment: $vm.equipment)
                    CharacterEngravingsView(findEngravingsElements: findEngravingsElements,
                                            isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                            engraving: $vm.engraving)
                    Spacer()
                }
                Spacer()
                
                VStack(alignment: .leading) {
//                    CharacterAccesoriesView(findAccessoriesElements: findAccessoriesElements,
//                                            accessoriesArray: vm.accessoriesArray,
//                                            isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
//                                            accessories: $vm.accessories)
//                    CharacterBraceletsView(findBraceletElements: findBraceletElements,
//                                           braceletArray: vm.braceletArray,
//                                           isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
//                                           bracelet: $vm.bracelet)
//                    CharacterAbilitystone(findAbilitystoneElements: findAbilitystoneElements,
//                                          abilitystoneArray: vm.abilitystoneArray,
//                                          isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
//                                          abilitystone: $vm.abilitystone)
                }
                Spacer()
            }
        } else if vm.isEquipmentsViewStatus == 1 {
            Button(action: {
                vm.isEquipmentsViewStatus = 0
            } ) {
                EquipmentDescriptionView(equipmentsArray: vm.equipmentsArray,
                                         isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                         equipment: $vm.equipment)
            }
        } else if vm.isEquipmentsViewStatus == 2 {
            Button(action: {
                vm.isEquipmentsViewStatus = 0
            } ) {
                EngravingDescriptionView(engravingName: $vm.engraving.name,
                                         engravingImage: $vm.engraving.image,
                                         engravingColor: $vm.engraving.color,
                                         engravingDescription: $vm.engraving.description,
                                         engravingLevel: $vm.engraving.level,
                                         engravingText: $vm.engraving.text)
            }
        } else if vm.isEquipmentsViewStatus == 3 {
            Button(action: {
                vm.isEquipmentsViewStatus = 0
            } ) {
                AccessoriesDescriptionView(accessoriesName: $vm.accessories.name,
                                           accessoriesImage: $vm.accessories.image,
                                           accessoriesColor: $vm.accessories.color,
                                           accessoriesOptionalText: $vm.accessories.optionalText,
                                           accessoriesOptionalStat: $vm.accessories.optionalStat,
                                           accessoriesRandomEffect1: $vm.accessories.randomEffect1,
                                           accessoriesRandomEffect2: $vm.accessories.randomEffect2,
                                           accessoriesRandomEffect3: $vm.accessories.randomEffect3,
                                           accessoriesQuality: $vm.accessories.quality,
                                           accessoriesQualityColor: $vm.accessories.qualityColor,
                                           accessoriesRandomEffectText: $vm.accessories.randomEffectText)
            }
        } else if vm.isEquipmentsViewStatus == 4 {
            Button(action: {
                vm.isEquipmentsViewStatus = 0
            } ) {
                BraceletDescriptionView(braceletName: $vm.bracelet.name,
                                        braceletImage: $vm.bracelet.image,
                                        braceletColor: $vm.bracelet.color,
                                        braceletStatText: $vm.bracelet.statText,
                                        braceletOptionalStat: $vm.bracelet.optionalStat,
                                        braceletEnchantText: $vm.bracelet.enchantText)
            }
        } else if vm.isEquipmentsViewStatus == 5 {
            Button(action: {
                vm.isEquipmentsViewStatus = 0
            } ) {
                AbilityStoneDescriptionView(abilitystoneName: $vm.abilitystone.name,
                                            abilitystoneImage: $vm.abilitystone.image,
                                            abilitystoneColor: $vm.abilitystone.color,
                                            abilitystoneBasicText: $vm.abilitystone.basicText,
                                            abilitystoneBasicStat: $vm.abilitystone.basicStat,
                                            abilitystoneOptionText: $vm.abilitystone.optionText,
                                            abilitystoneOptionStat: $vm.abilitystone.optionStat,
                                            abilitystoneOption1Text: $vm.abilitystone.option1Text,
                                            abilitystoneOption2Text: $vm.abilitystone.option2Text,
                                            abilitystoneOption3Text: $vm.abilitystone.option3Text,
                                            abilitystoneQuality: $vm.abilitystone.quality,
                                            abilitystoneQulityColor: $vm.abilitystone.qualityColor)
            }
            }
        }
    }
}


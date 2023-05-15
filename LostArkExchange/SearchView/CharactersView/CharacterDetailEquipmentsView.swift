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
    @StateObject private var searchCharacterEngravings = EngravingsAPI.shared
    let characterName: String
    
    var body: some View {
        if let searchCharacterEqupments = searchCharacterEqupments.posts?[characterName], let searchCharacterEngravings = searchCharacterEngravings.posts?[characterName]{
            let findEquipmentElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.equipmentsArray, itemType: Item.equipment)
            let findAccessoriesElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.accessoriesArray, itemType: Item.accessory)
            let findAbilitystoneElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.abilitystoneArray, itemType: Item.abilitystone)
            let findBraceletElements: [[String]] = findEquipments(itemDatas: searchCharacterEqupments, itemArray: vm.braceletArray, itemType: Item.bracelet)
            let findEngravingsElements: [[String]] = findEngravings(engravingDatas: searchCharacterEngravings.engravings)
            
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
                        CharacterAccesoriesView(findAccessoriesElements: findAccessoriesElements,
                                                accessoriesArray: vm.accessoriesArray,
                                                isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                                accessories: $vm.accessories)
                        CharacterBraceletsView(findBraceletElements: findBraceletElements,
                                               braceletArray: vm.braceletArray,
                                               isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                               bracelet: $vm.bracelet)
                        CharacterAbilitystone(findAbilitystoneElements: findAbilitystoneElements,
                                              abilitystoneArray: vm.abilitystoneArray,
                                              isEquipmentsViewStatus: $vm.isEquipmentsViewStatus,
                                              abilitystone: $vm.abilitystone)
                    }
                    Spacer()
                }
            } else if vm.isEquipmentsViewStatus == 1 {
                Button(action: {
                    vm.isEquipmentsViewStatus = 0
                } ) {
                    EquipmentDescriptionView(equipment: $vm.equipment)
                }
            } else if vm.isEquipmentsViewStatus == 2 {
                Button(action: {
                    vm.isEquipmentsViewStatus = 0
                } ) {
                    EngravingDescriptionView(engraving: $vm.engraving)
                }
            } else if vm.isEquipmentsViewStatus == 3 {
                Button(action: {
                    vm.isEquipmentsViewStatus = 0
                } ) {
                    AccessoriesDescriptionView(accessories: $vm.accessories)
                }
            } else if vm.isEquipmentsViewStatus == 4 {
                Button(action: {
                    vm.isEquipmentsViewStatus = 0
                } ) {
                    BraceletDescriptionView(bracelet: $vm.bracelet)
                }
            } else if vm.isEquipmentsViewStatus == 5 {
                Button(action: {
                    vm.isEquipmentsViewStatus = 0
                } ) {
                    AbilityStoneDescriptionView(abilitystone: $vm.abilitystone)
                }
            }
        }
    }
}


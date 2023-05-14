//
//  CharacterEquipmentsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterEquipmentsView: View {
    var findEquipmentElements: [[String]]
    var equipmentsArray: [String]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var equipment: EquipmentViewData
//    [weaponse, strQualityValue, basicText, basicStat, optionalText, optionalStat]
    var body: some View {
        ForEach(findEquipmentElements.indices, id: \.self) {equipmentIdx in
            if equipmentsArray.contains(findEquipmentElements[equipmentIdx][0]) {
                let equipmentImage =  findEquipmentElements[equipmentIdx][1]
                let equipmentName = findEquipmentElements[equipmentIdx][2]
                let equipmentQuality = findEquipmentElements[equipmentIdx][3]
                let equipmentBasicText =  findEquipmentElements[equipmentIdx][4]
                let equipmentBasicStat =  findEquipmentElements[equipmentIdx][5]
                let equipmentOptionText =  findEquipmentElements[equipmentIdx][6]
                let equipmentOptionStat =  findEquipmentElements[equipmentIdx][7]
                let qualityColor = findItemQualityColor(quaility: Int(equipmentQuality) ?? 0)

                HStack {
                    AsyncImage(url: URL(string: equipmentImage)) { phash in
                        if let image = phash.image {
                            image.ImageModifier()
                        } else if phash.error != nil {
                            Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                                .multilineTextAlignment(.leading)
                                .frame(height: h * 0.02)
                        } else {
                            Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                                .multilineTextAlignment(.leading)
                                .frame(height: h * 0.02)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(height: h * 0.02)
                    HTMLView(html: equipmentName, isScrollEnabled: false)
                        .frame(height: h * 0.001)
                    Text("[\(equipmentQuality)]")
                        .foregroundColor(qualityColor)
                }.onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 1
                    self.equipment.name = equipmentName
                    self.equipment.image = equipmentImage
                    self.equipment.quality = equipmentQuality
                    self.equipment.basicStat = equipmentBasicStat
                    self.equipment.optionStat = equipmentOptionStat
                    self.equipment.basicText = equipmentBasicText
                    self.equipment.optionText = equipmentOptionText
                    self.equipment.qualityColor = qualityColor
                })
                
            }
        }
    }
}

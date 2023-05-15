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
    
    var body: some View {
        ForEach(findEquipmentElements, id: \.self) { equipmentElement in
            let equipment: EquipmentViewData = makeEquipments(element: equipmentElement)
            if equipmentsArray.contains(equipmentElement[0]) {
                HStack {
                    AsyncImage(url: URL(string: equipment.image)) { phash in
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
                    Text("[\(equipment.name)]")
                        .foregroundColor(equipment.gradeColor)
                    Text("[\(equipment.quality)]")
                        .foregroundColor(equipment.qualityColor)
                }.onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 1
                    self.equipment = equipment
                })
                
            }
        }
    }
}

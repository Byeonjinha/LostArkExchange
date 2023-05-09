//
//  CharacterAbilitystone.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterAbilitystone: View {
    var findAbilitystoneElements: [[String]]
    var abilitystoneArray: [String]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var abilitystone: AbilitystoneViewData
    
    var body: some View {
        ForEach(findAbilitystoneElements.indices, id: \.self) {equipmentIdx in
            if abilitystoneArray.contains(findAbilitystoneElements[equipmentIdx][0]){
                let abilitystoneName = findAbilitystoneElements[equipmentIdx][1]
                let abilitystoneImage =  findAbilitystoneElements[equipmentIdx][2]
                let abilitystoneColor =  findAbilitystoneElements[equipmentIdx][4]
                let abilitystoneBasicText =  findAbilitystoneElements[equipmentIdx][5]
                let abilitystoneBasicStat =  findAbilitystoneElements[equipmentIdx][6]
                let abilitystoneOptionText =  findAbilitystoneElements[equipmentIdx][7]
                let abilitystoneOptionStat =  findAbilitystoneElements[equipmentIdx][8]
                let abilitystoneOption1Text =  findAbilitystoneElements[equipmentIdx][9]
                let abilitystoneOption2Text =  findAbilitystoneElements[equipmentIdx][10]
                let abilitystoneOption3Text =  findAbilitystoneElements[equipmentIdx][11]
                let abilitystoneQuality =  findAbilitystoneElements[equipmentIdx][12]
                let abilitystoneQulityColor = findItemQualityColor(quaility: Int(abilitystoneQuality) ?? 0)
                
                HStack {
                    AsyncImage(url: URL(string: abilitystoneImage)) { phash in
                        if let image = phash.image {
                            image.ImageModifier()
                        } else if phash.error != nil {
                            Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                                .multilineTextAlignment(.leading)
                                .frame(width: w * 0.05)
                        } else {
                            Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                                .multilineTextAlignment(.leading)
                                .frame(width: w * 0.05)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(width: w * 0.05)
                    HStack {
                        Text("\(abilitystoneName)")
                            .foregroundColor(Color(hex: abilitystoneColor))
                        
                        if abilitystoneQuality != "-1" {
                            Text("[\(abilitystoneQuality)]")
                                .foregroundColor(abilitystoneQulityColor)
                        }
                    }
                }
                .onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 5
                    self.abilitystone.name = abilitystoneName
                    self.abilitystone.image = abilitystoneImage
                    self.abilitystone.color = abilitystoneColor
                    self.abilitystone.name = abilitystoneName
                    self.abilitystone.image =  abilitystoneImage
                    self.abilitystone.color =  abilitystoneColor
                    self.abilitystone.basicText =   abilitystoneBasicText
                    self.abilitystone.basicStat =  abilitystoneBasicStat
                    self.abilitystone.optionText =  abilitystoneOptionText
                    self.abilitystone.optionStat =  abilitystoneOptionStat
                    self.abilitystone.option1Text =  abilitystoneOption1Text
                    self.abilitystone.option2Text =  abilitystoneOption2Text
                    self.abilitystone.option3Text =  abilitystoneOption3Text
                    self.abilitystone.quality = abilitystoneQuality
                    self.abilitystone.qualityColor = abilitystoneQulityColor
                })
            }
        }
    }
}

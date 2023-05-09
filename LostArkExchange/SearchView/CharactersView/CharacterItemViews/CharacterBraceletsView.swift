//
//  CharacterBraceletsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterBraceletsView: View {
    var findBraceletElements: [[String]]
    var braceletArray: [String]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var bracelet: BraceletViewData
    
    var body: some View {
        ForEach(findBraceletElements.indices, id: \.self) {equipmentIdx in
            if braceletArray.contains(findBraceletElements[equipmentIdx][0]){
                let braceletName = findBraceletElements[equipmentIdx][1]
                let braceletImage = findBraceletElements[equipmentIdx][2]
                let braceletColor = findBraceletElements[equipmentIdx][4]
                let braceletOptionalStatText = findBraceletElements[equipmentIdx][5]
                let braceletOptionalStat = findBraceletElements[equipmentIdx][6]
                let braceletCanEnchantText = findBraceletElements[equipmentIdx][7]
                
                HStack {
                    AsyncImage(url: URL(string: braceletImage)) { phash in
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
                        Text("\(braceletName)")
                            .foregroundColor(Color(hex: braceletColor))
                    }
                }
                .onTapGesture(perform: {
                    isEquipmentsViewStatus = 4
                    bracelet.name = braceletName
                    bracelet.image = braceletImage
                    bracelet.color = braceletColor
                    bracelet.statText = braceletOptionalStatText
                    bracelet.optionalStat = braceletOptionalStat
                    bracelet.enchantText = braceletCanEnchantText
                })
            }
        }
    }
}

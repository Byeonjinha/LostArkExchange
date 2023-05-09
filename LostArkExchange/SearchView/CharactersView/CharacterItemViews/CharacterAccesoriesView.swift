//
//  CharacterAccesoriesView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterAccesoriesView: View {
    var findAccessoriesElements: [[String]]
    var accessoriesArray: [String]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var accessories: AccessoriesViewData

    var body: some View {
        ForEach(findAccessoriesElements.indices, id: \.self) {equipmentIdx in
            if accessoriesArray.contains(findAccessoriesElements[equipmentIdx][0]) {
                let accessoriesName = findAccessoriesElements[equipmentIdx][1]
                let accessoriesImage =  findAccessoriesElements[equipmentIdx][2]
                let accessoriesColor =  findAccessoriesElements[equipmentIdx][4]
                let accessoriesOptionalText = findAccessoriesElements[equipmentIdx][5]
                let accessoriesOptionalStat = findAccessoriesElements[equipmentIdx][6]
                let accessoriesRandomEffect1 = findAccessoriesElements[equipmentIdx][7]
                let accessoriesRandomEffect2 = findAccessoriesElements[equipmentIdx][8]
                let accessoriesRandomEffect3 = findAccessoriesElements[equipmentIdx][9]
                let accessoriesQuality =  findAccessoriesElements[equipmentIdx][10]
                let accessoriesRandomEffectText = findAccessoriesElements[equipmentIdx][11]
                let qualityColor = findItemQualityColor(quaility: Int(accessoriesQuality) ?? 0)
                
                HStack {
                    AsyncImage(url: URL(string: accessoriesImage)) { phash in
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
                        Text("\(accessoriesName)")
                            .foregroundColor(Color(hex: accessoriesColor))

                        Text("[\(accessoriesQuality)]")
                            .foregroundColor(qualityColor)
                    }

                }
                .onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 3
                    self.accessories.name = accessoriesName
                    self.accessories.image = accessoriesImage
                    self.accessories.color = accessoriesColor
                    self.accessories.optionalText = accessoriesOptionalText
                    self.accessories.optionalStat = accessoriesOptionalStat
                    self.accessories.randomEffect1 = accessoriesRandomEffect1
                    self.accessories.randomEffect2 = accessoriesRandomEffect2
                    self.accessories.randomEffect3 = accessoriesRandomEffect3
                    self.accessories.quality = accessoriesQuality
                    self.accessories.qualityColor = qualityColor
                    self.accessories.randomEffectText = accessoriesRandomEffectText

                })
            }
        }
    }
}

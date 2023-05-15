//
//  EquipmentDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct EquipmentDescriptionView: View {
    @Binding var equipment: EquipmentViewData
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: equipment.image)) { phash in
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
                Text("\(equipment.name)")
                    .foregroundColor(equipment.gradeColor)
                Text("[\(equipment.quality)]")
                    .foregroundColor(equipment.qualityColor)
                Spacer()
            }
            HStack {
                VStack {
                    HTMLView(html: equipment.basicText, isScrollEnabled: false)
                    HTMLView(html: equipment.basicStat, isScrollEnabled: false)
                }
                VStack {
                    HTMLView(html: equipment.optionText, isScrollEnabled: false)
                    HTMLView(html: equipment.optionStat, isScrollEnabled: false)
                }
            }.frame(height: h * 0.1)
            Spacer()
        }
    }
}

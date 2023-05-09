//
//  EquipmentDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct EquipmentDescriptionView: View {
    
    @Binding var equipmentName: String
    @Binding var equipmentImage: String
    @Binding var equipmentQuality: String
    @Binding var equipmentBasicStat: String
    @Binding var equipmentOptionStat: String
    @Binding var equipmentBasicText: String
    @Binding var equipmentOptionText: String
    @Binding var equipmentColor: String
    @Binding var equipmentQulityColor: Color
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: equipmentImage)) { phash in
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
                Text("\(equipmentName)")
                    .foregroundColor(Color(hex: equipmentColor))
                Text("[\(equipmentQuality)]")
                    .foregroundColor(equipmentQulityColor)
                Spacer()
            }
            HStack {
                VStack {
                    HTMLView(html: equipmentBasicText, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html: equipmentBasicStat, isScrollEnabled: false)
                }
                VStack {
                    HTMLView(html: equipmentOptionText, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html: equipmentOptionStat, isScrollEnabled: false)
                }
            }
            Spacer()
        }
    }
}

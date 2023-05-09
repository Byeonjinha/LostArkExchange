//
//  AccessoriesDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct AccessoriesDescriptionView: View {
    
    @Binding var accessoriesName: String
    @Binding var accessoriesImage: String
    @Binding var accessoriesColor: String
    @Binding var accessoriesOptionalText: String
    @Binding var accessoriesOptionalStat: String
    @Binding var accessoriesRandomEffect1: String
    @Binding var accessoriesRandomEffect2: String
    @Binding var accessoriesRandomEffect3: String
    @Binding var accessoriesQuality: String
    @Binding var accessoriesQualityColor: Color
    @Binding var accessoriesRandomEffectText: String
    
    var body: some View {
        VStack {
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
                Text("\(accessoriesName)")
                    .foregroundColor(Color(hex: accessoriesColor))
                Text("[\(accessoriesQuality)]")
                    .foregroundColor(accessoriesQualityColor)
                Spacer()
            }
            HStack {
                VStack {
                    HTMLView(html: accessoriesOptionalText, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html: accessoriesOptionalStat, isScrollEnabled: false)
                    Spacer()
                }
                VStack {
                    HTMLView(html: "<FONT COLOR=\'#A9D0F5\'>무작위 각인 효과</FONT>", isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html:accessoriesRandomEffect1, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html:accessoriesRandomEffect2, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html:accessoriesRandomEffect3, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

//
//  AccessoriesDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct AccessoriesDescriptionView: View {
    @Binding var accessories: AccessoriesViewData
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: accessories.image)) { phash in
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
                Text("\(accessories.name)")
                    .foregroundColor(accessories.gradeColor)
                Text("[\(accessories.quality)]")
                    .foregroundColor(accessories.qualityColor)
                Spacer()
            }
            Spacer()
            HStack {
                VStack {
                    ForEach([accessories.optionalText, accessories.optionalStat], id: \.self) { content in
                        HTMLView(html: content, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                    }
                    Spacer()
                }
                VStack {
                    ForEach(["<FONT COLOR=\'#A9D0F5\'>무작위 각인 효과</FONT>",
                             accessories.randomEffect1,
                             accessories.randomEffect2,
                             accessories.randomEffect3], id: \.self) { content in
                        HTMLView(html: content, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

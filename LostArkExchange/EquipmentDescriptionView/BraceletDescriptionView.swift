//
//  BraceletDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct BraceletDescriptionView: View {
    @Binding var bracelet: BraceletViewData
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: bracelet.image)) { phash in
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
                Text("\(bracelet.name)")
                    .foregroundColor(bracelet.gradeColor)
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        HTMLView(html:bracelet.statText, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                        HTMLView(html: bracelet.enchantText, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                    }
                    HTMLView(html: bracelet.optionalStat, isScrollEnabled: true)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

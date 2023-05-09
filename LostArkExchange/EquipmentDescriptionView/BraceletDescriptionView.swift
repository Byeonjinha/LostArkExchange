//
//  BraceletDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct BraceletDescriptionView: View {
    @Binding var braceletName: String
    @Binding var braceletImage: String
    @Binding var braceletColor: String
    @Binding var braceletStatText: String
    @Binding var braceletOptionalStat: String
    @Binding var braceletEnchantText: String
    var body: some View {
        VStack {
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
                Text("\(braceletName)")
                    .foregroundColor(Color(hex: braceletColor))
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        HTMLView(html:braceletStatText, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                        HTMLView(html: braceletEnchantText, isScrollEnabled: false)
                            .frame(height: h * 0.025)
                    }
                    HTMLView(html: braceletOptionalStat, isScrollEnabled: true)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

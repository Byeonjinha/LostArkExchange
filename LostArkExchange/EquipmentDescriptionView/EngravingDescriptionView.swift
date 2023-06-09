//
//  EngravingDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct EngravingDescriptionView: View {
    
    @Binding var engraving: EngravingViewData
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: engraving.image)) { phash in
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
                Text("\(engraving.name) +\(engraving.level)")
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                VStack {
                    HTMLView(html: engraving.text, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html: engraving.description, isScrollEnabled: true)
                }
            }
            Spacer()
        }
    }
}

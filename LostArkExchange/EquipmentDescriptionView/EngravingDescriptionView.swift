//
//  EngravingDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct EngravingDescriptionView: View {
    
    @Binding var engravingName: String
    @Binding var engravingImage: String
    @Binding var engravingColor: String
    @Binding var engravingDescription: String
    @Binding var engravingLevel: String
    @Binding var engravingText: String
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: engravingImage)) { phash in
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
                Text("\(engravingName) +\(engravingLevel)")
                    .foregroundColor(Color(hex: engravingColor))
                Spacer()
            }
            HStack {
                VStack {
                    HTMLView(html: engravingText, isScrollEnabled: false)
                        .frame(height: h * 0.025)
                    HTMLView(html: engravingDescription, isScrollEnabled: true)
                }
            }
            Spacer()
        }
    }
}

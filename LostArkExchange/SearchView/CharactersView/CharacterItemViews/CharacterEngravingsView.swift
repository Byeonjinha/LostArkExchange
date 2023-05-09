//
//  CharacterEngravingsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterEngravingsView: View {
    var findEngravingsElements: [[String]]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var engraving: EngravingViewData
    
    var body: some View {
        ForEach(findEngravingsElements.indices, id: \.self) { engravingIdx in
            let engravingName = findEngravingsElements[engravingIdx][0]
            let engravingImage = findEngravingsElements[engravingIdx][1]
            let engravingColor = findEngravingsElements[engravingIdx][2]
            let engravingText = findEngravingsElements[engravingIdx][3]
            let engravingDescription =  findEngravingsElements[engravingIdx][4]
            let engravingLevel = findEngravingsElements[engravingIdx][5]

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
                HStack {
                    Text("\(engravingName) + \(engravingLevel)")
                        .foregroundColor(Color(hex: engravingColor))
                }
            }
            .onTapGesture(perform: {
                self.isEquipmentsViewStatus = 2
                self.engraving.name = engravingName
                self.engraving.image = engravingImage
                self.engraving.color = engravingColor
                self.engraving.text = engravingText
                self.engraving.description = engravingDescription
                self.engraving.level = engravingLevel
            })
        }
    }
}

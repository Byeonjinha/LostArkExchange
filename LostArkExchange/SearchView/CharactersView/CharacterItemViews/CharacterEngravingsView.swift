//
//  CharacterEngravingsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterEngravingsView: View {
    var findEngravingsElements: [[String]]
    
    @StateObject var vm = CharacterItemViewModel()
    
    @Binding var isEquipmentsViewStatus: Int
    @Binding var engraving: EngravingViewData
    
    var body: some View {
        ForEach(findEngravingsElements, id: \.self) { engravingsElements in
            let engraving = vm.makeEngraving(element: engravingsElements)

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
                HStack {
                    Text("\(engraving.name) + \(engraving.level)")
                        .foregroundColor(.white)
                }
            }
            .onTapGesture(perform: {
                self.isEquipmentsViewStatus = 2
                self.engraving = engraving
            })
        }
    }
}

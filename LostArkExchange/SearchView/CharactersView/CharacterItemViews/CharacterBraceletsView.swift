//
//  CharacterBraceletsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterBraceletsView: View {
    var findBraceletElements: [[String]]
    var braceletArray: [String]
    
    @StateObject var vm = CharacterItemViewModel()
    
    @Binding var isEquipmentsViewStatus: Int
    @Binding var bracelet: BraceletViewData
    
    var body: some View {
        ForEach(findBraceletElements, id: \.self) {braceletElement in
            let bracelet: BraceletViewData = vm.makeBracelet(element: braceletElement)
            if braceletArray.contains(bracelet.type){
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
                    HStack {
                        Text("\(bracelet.name)")
                            .foregroundColor(bracelet.gradeColor)
                    }
                }
                .onTapGesture(perform: {
                    isEquipmentsViewStatus = 4
                    self.bracelet = bracelet
                })
            }
        }
    }
}

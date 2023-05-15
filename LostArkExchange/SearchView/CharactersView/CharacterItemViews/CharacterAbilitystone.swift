//
//  CharacterAbilitystone.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterAbilitystone: View {
    var findAbilitystoneElements: [[String]]
    var abilitystoneArray: [String]
    
    @StateObject var vm = CharacterItemViewModel()
    
    @Binding var isEquipmentsViewStatus: Int
    @Binding var abilitystone: AbilitystoneViewData
    
    var body: some View {
        ForEach(findAbilitystoneElements, id: \.self) { abilitystoneElement in
            let abilitystone: AbilitystoneViewData = vm.makeAbilitystone(element: abilitystoneElement)
            if abilitystoneArray.contains(abilitystone.type){
                HStack {
                    AsyncImage(url: URL(string: abilitystone.image)) { phash in
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
                        Text("\(abilitystone.name)")
                            .foregroundColor(abilitystone.gradeColor)
                        
                        if abilitystone.quality != "-1" {
                            Text("[\(abilitystone.quality)]")
                                .foregroundColor(abilitystone.qualityColor)
                        }
                    }
                }
                .onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 5
                    self.abilitystone = abilitystone
                })
            }
        }
    }
}

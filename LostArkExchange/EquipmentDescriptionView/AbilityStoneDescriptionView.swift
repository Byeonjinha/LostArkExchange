//
//  AbilityStoneDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct AbilityStoneDescriptionView: View {
    @Binding var abilitystone: AbilitystoneViewData
    
    var body: some View {
        VStack {
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
                Text("\(abilitystone.name)")
                    .foregroundColor(abilitystone.gradeColor)
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        VStack {
                            ForEach([abilitystone.basicText, abilitystone.basicStat], id: \.self) { htmlText in
                                HTMLView(html: htmlText, isScrollEnabled: false)
                            }
                            .frame(height: h * 0.025)
                        }
                        VStack {
                            ForEach([abilitystone.optionText, abilitystone.optionStat], id: \.self) { htmlText in
                                HTMLView(html: htmlText, isScrollEnabled: false)
                            }
                            .frame(height: h * 0.025)
                        }
                    }
                    VStack {
                        ForEach(["<FONT COLOR=\'#A9D0F5\'>무작위 각인 효과</FONT>", abilitystone.option1Text, abilitystone.option2Text, abilitystone.option3Text], id: \.self) { htmlText in
                            HTMLView(html: htmlText, isScrollEnabled: false)
                        }
                        .frame(height: h * 0.025)
                    }
                    Spacer()
                }
            }
        }
    }
}

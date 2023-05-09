//
//  AbilityStoneDescriptionView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/27.
//

import SwiftUI

struct AbilityStoneDescriptionView: View {
    
    @Binding var abilitystoneName : String
    @Binding var abilitystoneImage : String
    @Binding var abilitystoneColor : String
    @Binding var abilitystoneBasicText: String
    @Binding var abilitystoneBasicStat: String
    @Binding var abilitystoneOptionText: String
    @Binding var abilitystoneOptionStat: String
    @Binding var abilitystoneOption1Text: String
    @Binding var abilitystoneOption2Text: String
    @Binding var abilitystoneOption3Text: String

    @Binding var abilitystoneQuality: String
    @Binding var abilitystoneQulityColor: Color
    
    
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: abilitystoneImage)) { phash in
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
                Text("\(abilitystoneName)")
                    .foregroundColor(Color(hex: abilitystoneColor))
                Spacer()
            }
            HStack {
                VStack {
                    HStack {
                        VStack {
                            ForEach([abilitystoneBasicText, abilitystoneBasicStat], id: \.self) { htmlText in
                                HTMLView(html: htmlText, isScrollEnabled: false)
                            }
                            .frame(height: h * 0.025)
                        }
                        VStack {
                            ForEach([abilitystoneOptionText, abilitystoneOptionStat], id: \.self) { htmlText in
                                HTMLView(html: htmlText, isScrollEnabled: false)
                            }
                            .frame(height: h * 0.025)
                        }
                    }
                    VStack {
                        ForEach(["<FONT COLOR=\'#A9D0F5\'>무작위 각인 효과</FONT>", abilitystoneOption1Text, abilitystoneOption2Text, abilitystoneOption3Text], id: \.self) { htmlText in
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

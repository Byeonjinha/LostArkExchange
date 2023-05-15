//
//  CharacterStatusView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/17.
//

import SwiftUI

struct CharacterStatusView: View {
    var characterName: String
    var characterClassName: String
    var characterLevel: String
    var serverName: String
    var itemAvgLevel: String
    var itemMaxLevel: String
    @State var isViewDetail: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(characterName)
                Spacer()
                Button(action:{
                    isViewDetail.toggle()
                }){
                    if isViewDetail {
                        Image(systemName: "chevron.up.circle")
                            .resizable()
                            .frame(width:18, height: 18)
                    } else {
                        Image(systemName: "chevron.down.circle")
                            .resizable()
                            .frame(width:18, height: 18)
                    }
                }
            }
            
            ScrollView (.horizontal, showsIndicators: false) {
                CharacterDetailView(characterName: characterName,
                                    characterClassName: characterClassName,
                                    characterLevel: characterLevel,
                                    serverName: serverName,
                                    itemAvgLevel: itemAvgLevel,
                                    itemMaxLevel: itemMaxLevel)
                .frame(width: w * 0.9 , height: isViewDetail ? h * 0.32 : 0)
            }
        }
    }
}

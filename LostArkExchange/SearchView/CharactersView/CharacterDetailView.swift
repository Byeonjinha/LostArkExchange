//
//  CharacterDetailView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/17.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject private var searchCharacterProfile = CharacterProfileAPI.shared
    @StateObject private var searchCharacterEqupments = EquipmentsAPI.shared
    @StateObject private var searchCharacterEngraings = EngravingsAPI.shared
    
    var characterName: String
    var characterClassName: String
    var characterLevel: String
    var serverName: String
    var itemAvgLevel: String
    var itemMaxLevel: String

    var body: some View {
        HStack {
            if searchCharacterProfile.posts?[characterName] != nil {
                let expeditionLevel: String = String(searchCharacterProfile.posts?[characterName]?.expeditionLevel ?? 0)
                
                if let characterImage =  searchCharacterProfile.posts?[characterName]?.characterImage {
                    VStack {
                        CharacterImageView(characterImage: characterImage, expeditionLevel: expeditionLevel, itemMaxLevel: itemMaxLevel, characterClassName: characterClassName, serverName: serverName)
                        Spacer()
                        CharacterDetailEquipmentsView(characterName: self.characterName)
                    }
                } else {
                    VStack {
                        HStack {
                            Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                .frame(width: w * 0.1)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.defaultBlue, lineWidth: 2)
                                    .frame(width: w * 0.12))
                                .padding()
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("서버: \(serverName)")
                                    Text("클래스: \(characterClassName)")
                                }
                                VStack(alignment: .leading) {
                                    Text("탐험 레벨: \(expeditionLevel)")
                                    Text("아이템 레벨: \(itemMaxLevel)")
                                }
                            }
                            
                            Spacer()
                        }
                        CharacterDetailEquipmentsView(characterName: self.characterName)
                    }
                }
            }
        }
        .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
    }
}


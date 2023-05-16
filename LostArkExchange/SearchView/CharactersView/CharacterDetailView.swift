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
    
    var gameData: GameData
    var body: some View {
        HStack {
            if searchCharacterProfile.posts?[gameData.characterName] != nil {
                let expeditionLevel: String = String(searchCharacterProfile.posts?[gameData.characterName]?.expeditionLevel ?? 0)
                if let characterImage =  searchCharacterProfile.posts?[gameData.characterName]?.characterImage {
                    VStack {
                        CharacterImageView(gameData: gameData, characterImage: characterImage, expeditionLevel: expeditionLevel)
                        Spacer()
                        CharacterDetailEquipmentsView(characterName: gameData.characterName)
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
                                    Text("서버: \(gameData.serverName)")
                                    Text("클래스: \(gameData.characterClassName)")
                                }
                                VStack(alignment: .leading) {
                                    Text("탐험 레벨: \(expeditionLevel)")
                                    Text("아이템 레벨: \(gameData.itemMaxLevel)")
                                }
                            }
                            
                            Spacer()
                        }
                        CharacterDetailEquipmentsView(characterName: gameData.characterName)
                    }
                }
            }
        }
        .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
    }
}


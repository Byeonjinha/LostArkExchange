//
//  ItemSkillOptionsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/09.
//

import SwiftUI

struct ItemSkillOptionsView: View {
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    
    @Binding var skillOptions: [SelectionSkillOptions]
    @Binding var classIdx: Int
    
    var idx: Int
    
    var body: some View {
        if !searchAuctionOptions.categories.isEmpty && skillOptions.count > idx{
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.15, height: h * 0.06)
                .overlay(
                    Menu {
                        Picker(selection:$classIdx) {
                            ForEach(searchAuctionOptions.skillOptionByCharacterClass.indices , id: \.self) {
                                Text(searchAuctionOptions.skillOptionByCharacterClass[$0].characterClass )
                            }
                        } label: {}
                    } label: {
                        HStack {
                            if skillOptions.count > idx {
                                Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].characterClass)
                                    .font(Font.custom("PoorStory-Regular", size: 12, relativeTo: .title))
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                )
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.2, height: h * 0.06)
                .overlay(
                    Menu {
                        Picker(selection: $skillOptions[idx].SkillOptionValue) {
                            ForEach(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions.indices , id: \.self) {
                                Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[$0].text)
                            }
                        } label: {}
                    } label: {
                        HStack {
                            if skillOptions.count > idx {
                                Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].text)
                                    .font(Font.custom("PoorStory-Regular", size: 12, relativeTo: .title))
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                )
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.2, height: h * 0.06)
                .overlay(
                    Menu {
                        Picker(selection: $skillOptions[idx].TripodValue) {
                            ForEach(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods.indices , id: \.self) {
                                if !searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[$0].isGem {
                                    Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[$0].text)
                                }
                            }
                        } label: {}
                    }label: {
                        HStack {
                            if skillOptions.count > idx && searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods.count > skillOptions[idx].TripodValue{
                                Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[skillOptions[idx].TripodValue].text)
                                    .font(Font.custom("PoorStory-Regular", size: 12, relativeTo: .title))
                                    .foregroundColor(.blue)
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                )
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.15, height: h * 0.06)
                .overlay(
                    TextField("" , text : $skillOptions[idx].minValue)
                        .keyboardType(.numbersAndPunctuation)
                        .placeholder(when: skillOptions[idx].minValue.isEmpty) {
                            Text("최소값")
                                .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
                        .foregroundColor(.gray)
                )
            
            
            Button(action: {  skillOptions.remove(at: idx)} ) {
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "minus.square")
                            .foregroundColor(.blue))
            }
        }
    }
}


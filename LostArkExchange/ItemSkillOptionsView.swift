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
            
            Picker("", selection:$classIdx) {
                ForEach(searchAuctionOptions.skillOptionByCharacterClass.indices , id: \.self) {
                    Text(searchAuctionOptions.skillOptionByCharacterClass[$0].characterClass )
                        .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                        .foregroundColor(.black)
                }
            }
            
            Picker("", selection: $skillOptions[idx].SkillOptionValue) {
                ForEach(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions.indices , id: \.self) {
                    Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[$0].text == "<font color=\'#c24b46\'>감소 효과</font>" ? "감소효과" : searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[$0].text)
                        .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
            .clipped()
            .compositingGroup()
            .onChange(of: skillOptions[idx].SkillOptionValue, perform: { sss in
                print(skillOptions[idx].SkillOptionValue)
            }
            )
            
            Picker("", selection: $skillOptions[idx].TripodValue) {
                ForEach(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods.indices , id: \.self) {
                    if !searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[$0].isGem {
                        Text(searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[$0].text)
                            .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            .foregroundColor(.black)
                    }
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
            .clipped()
            .compositingGroup()
            
            TextField("" , text : $skillOptions[idx].minValue)
                .keyboardType(.numbersAndPunctuation)
                .placeholder(when: skillOptions[idx].minValue.isEmpty) {
                    Text("0")
                        .foregroundColor(.gray)
                }
                .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                .foregroundColor(.gray)
            Button(action: {  skillOptions.remove(at: idx)} ) {Image(systemName: "minus")}
        }
    }
}


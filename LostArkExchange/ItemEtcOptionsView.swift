//
//  ItemEtcOptionsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/08.
//

import SwiftUI

struct ItemEtcOptionsView: View {
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    
    @Binding var etcOptions: [SelectionEtcOptions]
    var idx: Int
    
    var body: some View {
        if !searchAuctionOptions.categories.isEmpty && etcOptions.count > idx{

            Picker("", selection: $etcOptions[idx].etcOptionValue) {
                ForEach(searchAuctionOptions.posts[0].etcOptions.indices , id: \.self) {
                    Text(searchAuctionOptions.posts[0].etcOptions[$0].text == "<font color=\'#c24b46\'>감소 효과</font>" ? "감소효과" : searchAuctionOptions.posts[0].etcOptions[$0].text)
                        .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                        .foregroundColor(.black)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
            .clipped()
            .compositingGroup()
            .padding()

            Picker("", selection: $etcOptions[idx].etcSubValue) {
                ForEach(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs.indices , id: \.self) {
                    Text(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs[$0].text )
                        .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                        .foregroundColor(.black)

                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            .frame(width: UIScreen.main.bounds.width * 0.28, height: UIScreen.main.bounds.height * 0.14)
            .clipped()
            .compositingGroup()
            .padding()
            TextField("" , text : $etcOptions[idx].minValue)
                .keyboardType(.numbersAndPunctuation)
                .placeholder(when: etcOptions[idx].minValue.isEmpty) {
                    Text("0")
                        .foregroundColor(.gray)
                }
                .padding()
                .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                .foregroundColor(.gray)
            Button(action: {  etcOptions.remove(at: idx)} ) {Image(systemName: "minus")}
        }
    }
}


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
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.25, height: h * 0.06)
                .overlay(
                    Menu {
                        Picker(selection: $etcOptions[idx].etcOptionValue) {
                            ForEach(searchAuctionOptions.posts[0].etcOptions.indices , id: \.self) {
                                Text(searchAuctionOptions.posts[0].etcOptions[$0].text)
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            }
                        } label: {}
                    }  label: {
                        HStack {
                            Text(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].text)
                                .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.blue)
                        }
                    }
                        .onChange(of: etcOptions[idx].etcOptionValue, perform: { (value) in})
                )
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w * 0.28, height: h * 0.06)
                .overlay(
                    Menu {
                        Picker(selection: $etcOptions[idx].etcSubValue) {
                            ForEach(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs.indices , id: \.self) {
                                Text(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs[$0].text )
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            }
                        } label: {}
                    } label: {
                        HStack {
                            if etcOptions[idx].etcSubValue <
                                searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs.count {                            Text(searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs[etcOptions[idx].etcSubValue].text)
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
                    TextField("" , text : $etcOptions[idx].minValue)
                        .keyboardType(.numbersAndPunctuation)
                        .placeholder(when: etcOptions[idx].minValue.isEmpty) {
                            Text("최소값")
                                .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .font(Font.custom("PoorStory-Regular", size: 10, relativeTo: .title))
                        .foregroundColor(.gray)
                )
            Button(action: {  etcOptions.remove(at: idx)} ) {
                Rectangle()
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "minus.square")
                            .foregroundColor(.blue))
            }
            
        }
    }
}


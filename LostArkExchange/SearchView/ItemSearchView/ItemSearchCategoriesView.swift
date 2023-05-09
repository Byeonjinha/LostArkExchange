//
//  ItemSearchCategoriesView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import SwiftUI

struct ItemSearchCategoriesView: View {
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @Binding var choicedCategorie: Int
    @Binding var choicedGrade: Int
    @Binding var itemGradeQuality: Int
    @Binding var itemTier: Int
    
    var body: some View {
        if !searchAuctionOptions.categories.isEmpty {
            let categories: [(Int, String)] = searchAuctionOptions.categories
            let itemGrades: [String] = searchAuctionOptions.itemGrades!
            let itemGradeQualities: [Int] = searchAuctionOptions.itemGradeQualities!
            let itemTiers: [Int] = searchAuctionOptions.itemTiers!
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w*0.8, height: h*0.3 )
                .overlay(
            CategoriesPickerView(choicedCategorie: $choicedCategorie, choicedGrade: $choicedGrade, itemGradeQuality: $itemGradeQuality, itemTier: $itemTier, categories: categories, itemGrades: itemGrades, itemGradeQualities: itemGradeQualities, itemTiers: itemTiers)
            )
        } else {
            Color.defaultBlue
                .cornerRadius(5)
                .frame(width: w*0.8, height: h*0.3 )
        }
    }
}

//
//  ItemSearchView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import SwiftUI

struct ItemSearchView: View {
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    @Binding var searchItemName: String
    @Binding var selectionCategoriesOption: Int
    @Binding var selectionGradesOption: Int
    @Binding var selectionGradeQualitiesOption: Int
    @Binding var selectionTiersOption: Int
    
    @Binding var isSearchItemPresented: Bool
    
    @State var etcOptions: [SelectionEtcOptions] = []
    @State var skillOptions: [SelectionSkillOptions] = []
    @State var classIdx: Int = 0
    
//    @State var object: Object = ("dd")
    
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    TextField("" , text : $searchItemName)
                        .placeholder(when: searchItemName.isEmpty) {
                            Text("아이템 이름")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                        .foregroundColor(.gray)
                    Button(action:{
                        
                        let strEtcOptions: String = searchStrEtcOption()
                        let strSkillOptions: String = strSkillOption()
                        let itemGradeQuality: String = searchItemGradeQuality()
                        searchItemByCondition.posts = []
                        searchItemByCondition.getMyIP (
                            itemName: searchItemName,
                            itemGrade: searchAuctionOptions.itemGrades![selectionGradesOption],
                            categoryCode: searchAuctionOptions.categories[selectionCategoriesOption].0,
                            itemGradeQuality: itemGradeQuality ,
                            itemTier: searchAuctionOptions.itemTiers![selectionTiersOption],
                            etcOptions: strEtcOptions,
                            skillOptions: strSkillOptions
                        )
                        
                        self.isSearchItemPresented.toggle()
                    })
                    {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 15, height: 15)
                            .padding()
                    }
                }
                
                
                HStack {
                    ItemSearchCategoriesView(choicedCategorie: $selectionCategoriesOption, choicedGrade: $selectionGradesOption, itemGradeQuality: $selectionGradeQualitiesOption, itemTier: $selectionTiersOption)
                }
                SkillOptionsView(skillOptions: $skillOptions, classIdx: $classIdx)
                
                EtcOptionsView(etcOptions: $etcOptions)
                
            }
            Spacer()
        }
        .sheet(isPresented: $isSearchItemPresented) {
               SearcedItemView()
        }
    }
    func strSkillOption() -> String {
        var strSkillOptions: String = ""
        for idx in skillOptions.indices {
            let skillOptionsFirstOption =
            searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].value
         
            let skillOptionsSecondOption =
            searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[skillOptions[idx].TripodValue].value
            let minValue: String = skillOptions[idx].minValue
            strSkillOptions += """
{
"FirstOption": \(skillOptionsFirstOption),
"SecondOption": \(skillOptionsSecondOption),
"MinValue": \(minValue),
} ,
"""
        }
        return strSkillOptions
    }
    
    func searchStrEtcOption() -> String {
        var strEtcOptions = ""
        for idx in etcOptions.indices {
            let firstOption: Int = searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].value
            let secondOption: Int = searchAuctionOptions.posts[0].etcOptions[etcOptions[idx].etcOptionValue].etcSubs[etcOptions[idx].etcSubValue].value
            let minValue: String = etcOptions[idx].minValue
            strEtcOptions += """
{
"FirstOption": \(firstOption),
"SecondOption": \(secondOption),
"MinValue": \(minValue),
} ,
"""
        }
        return strEtcOptions
    }
    
    func searchItemGradeQuality() -> String {
        if selectionGradeQualitiesOption < searchAuctionOptions.itemGradeQualities!.count && searchAuctionOptions.categories[selectionCategoriesOption].1 != "아뮬렛" {
            let itemGradeQuality: Int = searchAuctionOptions.itemGradeQualities![selectionGradeQualitiesOption]
            return """
            "ItemGradeQuality": \(itemGradeQuality),
        """
        }
        return ""
    }
}

struct SelectionEtcOptions {
    var etcOptionValue: Int
    var etcSubValue: Int
    var minValue: String
}

struct SelectionSkillOptions {
    var SkillOptionValue: Int
    var TripodValue: Int
    var minValue: String
}


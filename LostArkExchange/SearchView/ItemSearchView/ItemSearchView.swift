//
//  ItemSearchView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import SwiftUI

struct ItemSearchView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ItemConditionEntity.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \ItemConditionEntity.timestamp, ascending: true)] )
    var itemConditionData: FetchedResults<ItemConditionEntity>
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    @Binding var searchItemInfo: SelectionOptions
    @Binding var searchItemConditions: SearchItemConditions!
    
    @ObservedObject var vm: ItemSearchViewModel
    init(searchItemInfo: Binding<SelectionOptions>, searchItemConditions: Binding<SearchItemConditions?>) {
        self._searchItemInfo = searchItemInfo
        self._searchItemConditions = searchItemConditions
        _vm = ObservedObject(initialValue: ItemSearchViewModel(searchAuctionOptions: AuctionOptionsAPI.shared, searchItemByCondition: AuctionItemsAPI.shared, searchItemInfo: searchItemInfo))
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Color.defaultBlue
                        .cornerRadius(5)
                        .frame(width: w * 0.6, height: h * 0.05)
                        .overlay(
                            HStack {
                                TextField("" , text : $vm.searchItemInfo.itemName)
                                    .placeholder(when: vm.searchItemInfo.itemName.isEmpty) {
                                        Text("아이템 이름")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                    .foregroundColor(.gray)
                                Button(action:{
                                    if !searchAuctionOptions.posts.isEmpty {
                                        let strEtcOptions: String = vm.searchStrEtcOption()
                                        let strSkillOptions: String = vm.strSkillOption()
                                        let itemGradeQuality: String = vm.searchItemGradeQuality()
                                        
                                        vm.strEtcOptions = strEtcOptions
                                        vm.itemGradeQuality = itemGradeQuality
                                        vm.strSkillOptions = strSkillOptions
                                        
                                        let parameter = vm.transSearchCondition(
                                            itemName: vm.searchItemInfo.itemName,
                                            itemGrade: searchAuctionOptions.itemGrades![vm.searchItemInfo.grades],
                                            categoryCode: searchAuctionOptions.categories[vm.searchItemInfo.categories].0,
                                            itemGradeQuality: itemGradeQuality ,
                                            itemTier: searchAuctionOptions.itemTiers![vm.searchItemInfo.tiers],
                                            etcOptions: strEtcOptions,
                                            skillOptions: strSkillOptions,
                                            pageNo: 1
                                        )
                                        
                                        searchItemByCondition.posts = []
                                        searchItemByCondition.getMyIP (
                                            parameter: parameter
                                        )
                                        self.searchItemConditions = SearchItemConditions(
                                            searchItemName: vm.searchItemInfo.itemName,
                                            selectionGradesOption: searchAuctionOptions.itemGrades![vm.searchItemInfo.grades],
                                            selectionCategoriesOption: searchAuctionOptions.categories[vm.searchItemInfo.categories].0,
                                            itemGradeQuality: itemGradeQuality,
                                            selectionTiersOption: searchAuctionOptions.itemTiers![vm.searchItemInfo.tiers],
                                            strEtcOptions: strEtcOptions,
                                            strSkillOptions: strSkillOptions)
                                        
                                        
                                    } else {
                                        vm.showingServerAlert.toggle()
                                    }
                                })
                                {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 15, height: 15)
                                        .padding()
                                        .alert("주의", isPresented: $vm.showingServerAlert) {
                                            Button("Ok") {}
                                        } message: {
                                            Text("서버 정보를 받을 수 없습니다.")
                                        }
                                }
                            }
                        )
                        .padding()
                    Button(action:{
                        vm.addConditionName.value = ""
                        vm.isAddConditionOn = true
                    }){
                        Image(systemName: "plus.square.fill")
                    }
                    Button(action:{
                        vm.isBookmarkOn = true
                    }){
                        Image(systemName: "bookmark.fill")
                    }
                }
                
                HStack {
                    ItemSearchCategoriesView(searchItemInfo: $searchItemInfo)
                }
                ScrollView {
                    VStack {
                        SkillOptionsView(skillOptions: $vm.skillOptions, classIdx: $vm.classIdx)
                            .frame(width: w)
                            .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            .foregroundColor(.gray)
                        EtcOptionsView(etcOptions: $vm.etcOptions)
                            .frame(width: w)
                            .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(item: $searchItemConditions) { item in
                let searchItemconditions: SearchItemConditions = SearchItemConditions(searchItemName: vm.searchItemInfo.itemName,
                                     selectionGradesOption: searchAuctionOptions.itemGrades![vm.searchItemInfo.grades],
                                     selectionCategoriesOption: searchAuctionOptions.categories[vm.searchItemInfo.categories].0,
                                     itemGradeQuality: vm.itemGradeQuality,
                                     selectionTiersOption: searchAuctionOptions.itemTiers![vm.searchItemInfo.tiers],
                                     strEtcOptions: vm.strEtcOptions,
                                     strSkillOptions: vm.strSkillOptions)
                
                
                SearchedItemView(searchItemConditions: searchItemconditions, pageNo: 1)
            }
            if vm.isAddConditionOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            vm.isAddConditionOn = false
                        }
                    ItemAddView(vm: self.vm)
                }
            }
            if  vm.isBookmarkOn {
                BookmarkView(searchItemConditions: $searchItemConditions, vm: self.vm)
            }
        }
    }
}


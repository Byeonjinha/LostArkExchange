//  BookmarkView.swift
//  Pods
//
//  Created by Byeon jinha on 2023/05/16.
//

import SwiftUI

struct BookmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ItemConditionEntity.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \ItemConditionEntity.timestamp, ascending: true)] )
    var itemConditionData: FetchedResults<ItemConditionEntity>
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    @Binding var searchItemConditions: SearchItemConditions!
    
    @ObservedObject var vm: ItemSearchViewModel
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .onTapGesture {
                    vm.isBookmarkOn = false
                }
            RoundedRectangle(cornerRadius: 10)
                .frame(width: w * 0.8 , height: h * 0.5)
                .overlay(
                    List {
                        ForEach(itemConditionData.indices , id: \.self) {idx in
                            Button(action:{
                                if !searchAuctionOptions.posts.isEmpty {
                                    let strEtcOptions: String = vm.searchStrEtcOption()
                                    let strSkillOptions: String = vm.strSkillOption()
                                    let itemGradeQuality: String = vm.searchItemGradeQuality()
                                    
                                    vm.strEtcOptions = strEtcOptions
                                    vm.itemGradeQuality = itemGradeQuality
                                    vm.strSkillOptions = strSkillOptions
                                    
                                    let parameter = vm.transSearchCondition(
                                        itemName: itemConditionData[idx].itemName!,
                                        itemGrade: itemConditionData[idx].itemGrade!,
                                        categoryCode: Int(itemConditionData[idx].categoryCode),
                                        itemGradeQuality: itemConditionData[idx].itemGradeQuality! ,
                                        itemTier: Int(itemConditionData[idx].itemTier),
                                        etcOptions: itemConditionData[idx].etcOptions!,
                                        skillOptions: itemConditionData[idx].skillOptions!,
                                        pageNo: 1
                                    )
                                    searchItemByCondition.posts = []
                               
                                    searchItemByCondition.getMyIP (
                                        parameter: parameter
                                    )
                                    self.searchItemConditions = SearchItemConditions(
                                        searchItemName: itemConditionData[idx].itemName!,
                                        selectionGradesOption: itemConditionData[idx].itemGrade!,
                                        selectionCategoriesOption: Int(itemConditionData[idx].categoryCode),
                                        itemGradeQuality: itemConditionData[idx].itemGradeQuality!,
                                        selectionTiersOption: Int(itemConditionData[idx].itemTier),
                                        strEtcOptions: itemConditionData[idx].etcOptions!,
                                        strSkillOptions: itemConditionData[idx].skillOptions!)
                                } else {
                                    vm.showingServerAlert.toggle()
                                }
                            })
                            {
                                Rectangle()
                                    .alert("주의", isPresented: $vm.showingServerAlert) {
                                        Button("Ok") {}
                                    } message: {
                                        Text("서버 정보를 받을 수 없습니다.")
                                    }
                                    .foregroundColor(.clear)
                                    .overlay(
                                        Text(itemConditionData[idx].conditionName!)
                                    )
                            }
                            .sheet(item: $searchItemConditions) { item in
                                let searchItemconditions: SearchItemConditions =
                                SearchItemConditions(searchItemName: item.searchItemName,
                                                     selectionGradesOption: item.selectionGradesOption,
                                                     selectionCategoriesOption: item.selectionCategoriesOption,
                                                     itemGradeQuality: item.itemGradeQuality,
                                                     selectionTiersOption: item.selectionTiersOption,
                                                     strEtcOptions: item.strEtcOptions,
                                                     strSkillOptions:  item.strSkillOptions)
                                SearchedItemView(searchItemConditions: searchItemconditions, pageNo: 1)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                        .opacity(0.9)
                )
        }
    }
    func deleteItems(offsets: IndexSet) {
        print(offsets)
            offsets.map { itemConditionData[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
    }
}

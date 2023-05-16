//
//  ItemAddView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/16.
//

import SwiftUI

struct ItemAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ItemConditionEntity.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \ItemConditionEntity.timestamp, ascending: true)] )
    var itemConditionData: FetchedResults<ItemConditionEntity>
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    @ObservedObject var vm: ItemSearchViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: w * 0.8 , height: h * 0.2)
            .overlay(
                VStack {
                    Text("아이템 검색 조건 저장")
                        .foregroundColor(Color.defaultBlue)
                    HStack {
                        Color.defaultBlue
                            .cornerRadius(5)
                            .frame(width: w * 0.6, height: h * 0.05)
                            .overlay(
                                TextField("" , text : $vm.addConditionName.value)
                                    .placeholder(when: vm.addConditionName.value.isEmpty) {
                                        Text("아이템 조건 이름")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                    .foregroundColor(.gray)
                            )
                        Button(action: {
                            if vm.addConditionName.value.isEmpty {
                                vm.showingTextNullAlert.toggle()
                            } else {
                                addItem(conditionName: vm.addConditionName.value,
                                        itemName: vm.searchItemInfo.itemName,
                                        itemGrade: searchAuctionOptions.itemGrades![vm.searchItemInfo.grades],
                                        categoryCode: searchAuctionOptions.categories[vm.searchItemInfo.categories].0,
                                        itemGradeQuality: vm.itemGradeQuality ,
                                        itemTier: searchAuctionOptions.itemTiers![vm.searchItemInfo.tiers],
                                        etcOptions: vm.strEtcOptions,
                                        skillOptions: vm.strSkillOptions)
                                vm.isAddConditionOn = false
                                
                                
                            }
                            
                        })
                        {
                            Image(systemName: "plus.square")
                                .alert("주의", isPresented: $vm.showingTextNullAlert) {
                                    Button("Ok") {}
                                } message: {
                                    Text("조건을 공백으로 저장할 수 없습니다.")
                                }
                        }
                    }
                }
            )
    }
    func addItem(conditionName: String, itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String) {
        let newData = ItemConditionEntity(context: viewContext)
        newData.populate(conditionName: conditionName, itemName: itemName, itemGrade: itemGrade, categoryCode: categoryCode, itemGradeQuality: itemGradeQuality, itemTier: itemTier, etcOptions: etcOptions, skillOptions: skillOptions)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

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
    init(searchItemInfo: Binding<SelectionOptions>,
         searchItemConditions: Binding<SearchItemConditions?>) {
        self._searchItemInfo = searchItemInfo
        self._searchItemConditions = searchItemConditions
        _vm = ObservedObject(initialValue: ItemSearchViewModel(searchItemInfo: searchItemInfo))
    }
    
    public func addItem(conditionName: String, itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String) {
        let newData = ItemConditionEntity(context: viewContext)
        newData.populate(conditionName: conditionName, itemName: itemName, itemGrade: itemGrade, categoryCode: categoryCode, itemGradeQuality: itemGradeQuality, itemTier: itemTier, etcOptions: etcOptions, skillOptions: skillOptions)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { itemConditionData[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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
                SearchedItemView(
                    searchItemName: vm.searchItemInfo.itemName,
                    gradesOption: searchAuctionOptions.itemGrades![vm.searchItemInfo.grades],
                    categoriesOption: searchAuctionOptions.categories[vm.searchItemInfo.categories].0,
                    itemGradeQuality: vm.itemGradeQuality,
                    tiersOption: searchAuctionOptions.itemTiers![vm.searchItemInfo.tiers],
                    strEtcOptions: vm.strEtcOptions,
                    strSkillOptions: vm.strSkillOptions, pageNo: 1)
                
            }
            if vm.isAddConditionOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            vm.isAddConditionOn = false
                        }
                    if #available(iOS 16.0, *) {
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
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            if  vm.isBookmarkOn {
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
                                        SearchedItemView(
                                            searchItemName: item.searchItemName,
                                            gradesOption: item.selectionGradesOption,
                                            categoriesOption: item.selectionCategoriesOption,
                                            itemGradeQuality: item.itemGradeQuality,
                                            tiersOption: item.selectionTiersOption,
                                            strEtcOptions: item.strEtcOptions,
                                            strSkillOptions: item.strSkillOptions,
                                            pageNo: 1)
                                    }
                                }
                                .onDelete(perform: deleteItems)
                            }
                                .opacity(0.9)
                        )
                }
            }
        }
    }
}

extension ItemConditionEntity {
    func populate(conditionName: String, itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String) {
        self.conditionName = conditionName
        self.itemName = itemName
        self.itemGrade = itemGrade
        self.categoryCode = Int64(categoryCode)
        self.itemGradeQuality = itemGradeQuality
        self.itemTier = Int64(itemTier)
        self.etcOptions = etcOptions
        self.skillOptions = skillOptions
        self.timestamp = Date()
    }
}

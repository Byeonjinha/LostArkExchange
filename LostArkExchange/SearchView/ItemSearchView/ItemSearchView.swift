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
    
    @Binding var searchItemName: String
    @Binding var selectionCategoriesOption: Int
    @Binding var selectionGradesOption: Int
    @Binding var selectionGradeQualitiesOption: Int
    @Binding var selectionTiersOption: Int
    
    @State var etcOptions: [SelectionEtcOptions] = []
    @State var skillOptions: [SelectionSkillOptions] = []
    @State var classIdx: Int = 0
    
    @State private var itemGradeQuality: String = ""
    @State private var strEtcOptions: String = ""
    @State private var strSkillOptions: String = ""
    
    @State private var showingServerAlert: Bool = false
    @State private var showingTextNullAlert: Bool = false
    
    @State private var isBookmarkOn: Bool = false
    @State private var isAddConditionOn: Bool = false
    @ObservedObject var addConditionName = TextLimiter(limit: 16)
    
    @Binding var searchItemConditions: SearchItemConditions!
    
    public func addItem(conditionName: String, itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String) {
        let newData = ItemConditionEntity(context: viewContext)
        newData.conditionName = conditionName
        newData.itemName = itemName
        newData.itemGrade = itemGrade
        newData.categoryCode = Int64(categoryCode)
        newData.itemGradeQuality = itemGradeQuality
        newData.itemTier = Int64(itemTier)
        newData.etcOptions = etcOptions
        newData.skillOptions = skillOptions
        newData.timestamp = Date()
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
                                TextField("" , text : $searchItemName)
                                    .placeholder(when: searchItemName.isEmpty) {
                                        Text("아이템 이름")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                    .foregroundColor(.gray)
                                Button(action:{
                                    if !searchAuctionOptions.posts.isEmpty {
                                        let strEtcOptions: String = searchStrEtcOption()
                                        let strSkillOptions: String = strSkillOption()
                                        let itemGradeQuality: String = searchItemGradeQuality()
                                        
                                        self.strEtcOptions = strEtcOptions
                                        self.itemGradeQuality = itemGradeQuality
                                        self.strSkillOptions = strSkillOptions
                                        
                                        let parameter = transSearchCondition(
                                            itemName: searchItemName,
                                            itemGrade: searchAuctionOptions.itemGrades![selectionGradesOption],
                                            categoryCode: searchAuctionOptions.categories[selectionCategoriesOption].0,
                                            itemGradeQuality: itemGradeQuality ,
                                            itemTier: searchAuctionOptions.itemTiers![selectionTiersOption],
                                            etcOptions: strEtcOptions,
                                            skillOptions: strSkillOptions,
                                            pageNo: 1
                                        )
                                        
                                        searchItemByCondition.posts = []
                                        searchItemByCondition.getMyIP (
                                            parameter: parameter
                                        )
                                        self.searchItemConditions = SearchItemConditions(
                                            searchItemName: searchItemName,
                                            selectionGradesOption: searchAuctionOptions.itemGrades![selectionGradesOption],
                                            selectionCategoriesOption: searchAuctionOptions.categories[selectionCategoriesOption].0,
                                            itemGradeQuality: itemGradeQuality,
                                            selectionTiersOption: searchAuctionOptions.itemTiers![selectionTiersOption],
                                            strEtcOptions: strEtcOptions,
                                            strSkillOptions: strSkillOptions)
                                        
                                        
                                    } else {
                                        showingServerAlert.toggle()
                                    }
                                })
                                {
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 15, height: 15)
                                        .padding()
                                        .alert("주의", isPresented: $showingServerAlert) {
                                            Button("Ok") {}
                                        } message: {
                                            Text("서버 정보를 받을 수 없습니다.")
                                        }
                                }
                            }
                        )
                        .padding()
                    Button(action:{
                        addConditionName.value = ""
                        self.isAddConditionOn = true
                    }){
                        Image(systemName: "plus.square.fill")
                    }
                    Button(action:{
                        self.isBookmarkOn = true
                    }){
                        Image(systemName: "bookmark.fill")
                    }
                }
                
                HStack {
                    ItemSearchCategoriesView(choicedCategorie: $selectionCategoriesOption, choicedGrade: $selectionGradesOption, itemGradeQuality: $selectionGradeQualitiesOption, itemTier: $selectionTiersOption)
                }
                ScrollView {
                    VStack {
                        SkillOptionsView(skillOptions: $skillOptions, classIdx: $classIdx)
                            .frame(width: w)
                            .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            .foregroundColor(.gray)
                        EtcOptionsView(etcOptions: $etcOptions)
                            .frame(width: w)
                            .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                            .foregroundColor(.gray)
                    }
                }
            }
            .sheet(item: $searchItemConditions) { item in
                SearchedItemView(
                    searchItemName: searchItemName,
                    gradesOption: searchAuctionOptions.itemGrades![selectionGradesOption],
                    categoriesOption: searchAuctionOptions.categories[selectionCategoriesOption].0,
                    itemGradeQuality: itemGradeQuality,
                    tiersOption: searchAuctionOptions.itemTiers![selectionTiersOption],
                    strEtcOptions: strEtcOptions,
                    strSkillOptions: strSkillOptions, pageNo: 1)
                
            }
            if isAddConditionOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            self.isAddConditionOn = false
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
                                                TextField("" , text : $addConditionName.value)
                                                    .placeholder(when: addConditionName.value.isEmpty) {
                                                        Text("아이템 조건 이름")
                                                            .foregroundColor(.gray)
                                                    }
                                                    .padding()
                                                    .font(Font.custom("PoorStory-Regular", size: 15, relativeTo: .title))
                                                    .foregroundColor(.gray)
                                            )
                                        Button(action: {
                                            if addConditionName.value.isEmpty {
                                                showingTextNullAlert.toggle()
                                            } else {
                                                addItem(conditionName: addConditionName.value,
                                                        itemName: searchItemName,
                                                        itemGrade: searchAuctionOptions.itemGrades![selectionGradesOption],
                                                        categoryCode: searchAuctionOptions.categories[selectionCategoriesOption].0,
                                                        itemGradeQuality: itemGradeQuality ,
                                                        itemTier: searchAuctionOptions.itemTiers![selectionTiersOption],
                                                        etcOptions: strEtcOptions,
                                                        skillOptions: strSkillOptions)
                                                self.isAddConditionOn = false
                                                
                                                
                                            }
                                            
                                        })
                                        {
                                            Image(systemName: "plus.square")
                                                .alert("주의", isPresented: $showingTextNullAlert) {
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
            if isBookmarkOn {
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .onTapGesture {
                            self.isBookmarkOn = false
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: w * 0.8 , height: h * 0.5)
                        .overlay(
                            List {
                                ForEach(itemConditionData.indices , id: \.self) {idx in
                                    Button(action:{
                                        if !searchAuctionOptions.posts.isEmpty {
                                            let strEtcOptions: String = searchStrEtcOption()
                                            let strSkillOptions: String = strSkillOption()
                                            let itemGradeQuality: String = searchItemGradeQuality()
                                            
                                            self.strEtcOptions = strEtcOptions
                                            self.itemGradeQuality = itemGradeQuality
                                            self.strSkillOptions = strSkillOptions
                                            
                                            let parameter = transSearchCondition(
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
                                            showingServerAlert.toggle()
                                        }
                                    })
                                    {
                                        Rectangle()
                                            .alert("주의", isPresented: $showingServerAlert) {
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
    func strSkillOption() -> String {
        var strSkillOptions: String = ""
        for idx in skillOptions.indices {
            let skillOptionsFirstOption =
            searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].value
            var skillOptionsSecondOption = 0
            if searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods.count > skillOptions[idx].TripodValue {
                skillOptionsSecondOption =
                searchAuctionOptions.skillOptionByCharacterClass[classIdx].skillOptions[skillOptions[idx].SkillOptionValue].tripods[skillOptions[idx].TripodValue].value
            }
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
        if selectionGradeQualitiesOption < searchAuctionOptions.itemGradeQualities!.count && searchAuctionOptions.categories[selectionCategoriesOption].1 != "아뮬렛" && searchAuctionOptions.categories[selectionCategoriesOption].1 != "팔찌"{
            let itemGradeQuality: Int = searchAuctionOptions.itemGradeQualities![selectionGradeQualitiesOption]
            return
"""
"ItemGradeQuality": \(itemGradeQuality),
"""
        } else if selectionGradeQualitiesOption == searchAuctionOptions.itemGradeQualities!.count && searchAuctionOptions.categories[selectionCategoriesOption].1 != "아뮬렛" && searchAuctionOptions.categories[selectionCategoriesOption].1 != "팔찌"{
            return
"""
"ItemGradeQuality": 100,
"""
        }
        
        return ""
    }
    
    func transSearchCondition(itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String, pageNo: Int) -> String {
        let parameter: String =
"""
{
  "ItemLevelMin": 0,
  "ItemLevelMax": 1700,
\(itemGradeQuality)
  "SKillOptions": [
    \(skillOptions)
  ],
  "EtcOptions": [
    \(etcOptions)
  ],
  "Sort": "BIDSTART_PRICE",
  "CategoryCode": \(categoryCode),
  "CharacterClass": "",
  "ItemTier": \(itemTier),
  "ItemGrade": "\(itemGrade)",
  "ItemName": "\(itemName)",
  "PageNo": "\(pageNo)",
  "SortCondition": "ASC"
}
"""
        return parameter
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

struct SearchItemConditions: Identifiable {
    var id = UUID()
    var searchItemName: String
    var selectionGradesOption: String
    var selectionCategoriesOption: Int
    var itemGradeQuality: String
    var selectionTiersOption: Int
    var strEtcOptions: String
    var strSkillOptions: String
}

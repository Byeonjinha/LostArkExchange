    //
    //  ItemSearchViewModel.swift
    //  LostArkExchange
    //
    //  Created by Byeon jinha on 2023/05/16.
    //

    import SwiftUI

    class ItemSearchViewModel: ObservableObject{
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(entity: ItemConditionEntity.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \ItemConditionEntity.timestamp, ascending: true)] )
        var itemConditionData: FetchedResults<ItemConditionEntity>
        
        private var searchAuctionOptions: AuctionOptionsAPI
        private var searchItemByCondition: AuctionItemsAPI
        
        @Binding var searchItemInfo: SelectionOptions
    //      init(searchItemInfo: Binding<SelectionOptions>) {
    //          _searchItemInfo = searchItemInfo
    //      }
        init(searchAuctionOptions: AuctionOptionsAPI, searchItemByCondition: AuctionItemsAPI, searchItemInfo: Binding<SelectionOptions>) {
            self.searchAuctionOptions = searchAuctionOptions
            self.searchItemByCondition = searchItemByCondition
            _searchItemInfo = searchItemInfo
        }
        @Published var etcOptions: [SelectionEtcOptions] = []
        @Published var skillOptions: [SelectionSkillOptions] = []
        @Published var classIdx: Int = 0
        
        @Published var itemGradeQuality: String = ""
        @Published var strEtcOptions: String = ""
        @Published var strSkillOptions: String = ""
        
        @Published var showingServerAlert: Bool = false
        @Published var showingTextNullAlert: Bool = false
        
        @Published var isBookmarkOn: Bool = false
        @Published var isAddConditionOn: Bool = false
        @Published var addConditionName = TextLimiter(limit: 16)
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
            if searchItemInfo.gradeQualities < searchAuctionOptions.itemGradeQualities!.count && searchAuctionOptions.categories[searchItemInfo.categories].1 != "아뮬렛" && searchAuctionOptions.categories[searchItemInfo.categories].1 != "팔찌"{
                let itemGradeQuality: Int = searchAuctionOptions.itemGradeQualities![searchItemInfo.gradeQualities]
                return
    """
    "ItemGradeQuality": \(itemGradeQuality),
    """
            } else if searchItemInfo.gradeQualities == searchAuctionOptions.itemGradeQualities!.count && searchAuctionOptions.categories[searchItemInfo.categories].1 != "아뮬렛" && searchAuctionOptions.categories[searchItemInfo.categories].1 != "팔찌"{
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

//
//  SearchedItemView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/10.
//

import SwiftUI

struct SearchedItemView: View {
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    var searchItemConditions: SearchItemConditions
    
    @State var preventButtonTouch = false
    @State var pageNo: Int
    
    var body: some View {
        VStack {
            if !searchItemByCondition.posts.isEmpty {
                HStack {
                    let totalPageNo: Int = (searchItemByCondition.posts[0].totalCount! / searchItemByCondition.posts[0].pageSize!+1 )
                    Button(action: {
                        if self.preventButtonTouch == true {
                            return
                        }
                        
                        self.preventButtonTouch = true
                        if pageNo != 1 {
                            searchItemByCondition.posts = []
                            pageNo -= 1
                            let parameter = transSearchCondition(
                                itemName: searchItemConditions.searchItemName,
                                itemGrade: searchItemConditions.selectionGradesOption,
                                categoryCode: searchItemConditions.selectionCategoriesOption,
                                itemGradeQuality: searchItemConditions.itemGradeQuality ,
                                itemTier: searchItemConditions.selectionTiersOption,
                                etcOptions: searchItemConditions.strEtcOptions,
                                skillOptions: searchItemConditions.strSkillOptions,
                                pageNo: pageNo
                            )
                            print(parameter, "asdfkajskdjfn????")
                            searchItemByCondition.getMyIP (parameter: parameter)
                        }
                        preventButtonTouch = false
                    }){
                        Image(systemName: "chevron.backward.circle")
                    }
                    
                    Text("페이지 : \(pageNo)")
                    Text("/")
                    Text("\(totalPageNo)")
                    Button(action: {
                        if self.preventButtonTouch == true {
                            return
                        }
                        
                        self.preventButtonTouch = true
                        if !searchItemByCondition.posts.isEmpty {
                            if ((searchItemByCondition.posts[0].totalCount! / searchItemByCondition.posts[0].pageSize!)+1 != pageNo) {
                                
                                searchItemByCondition.posts = []
                                pageNo += 1
                                let parameter = transSearchCondition(
                                    itemName: searchItemConditions.searchItemName,
                                    itemGrade: searchItemConditions.selectionGradesOption,
                                    categoryCode: searchItemConditions.selectionCategoriesOption,
                                    itemGradeQuality: searchItemConditions.itemGradeQuality ,
                                    itemTier: searchItemConditions.selectionTiersOption,
                                    etcOptions: searchItemConditions.strEtcOptions,
                                    skillOptions: searchItemConditions.strSkillOptions,
                                    pageNo: pageNo
                                )
                                print(parameter, "mmmmmmmm????")
//                                searchItemByCondition.getMyIP (parameter: parameter)
                            }
                        }
                        preventButtonTouch = false
                    }){
                        Image(systemName: "chevron.forward.circle")
                    }
                }
                .frame(height: h * 0.05)
                ScrollView {
                    if !(searchItemByCondition.posts[0].items == nil) {
                        List {
                            ForEach(searchItemByCondition.posts[0].items!.indices , id:\.self) { idx in
                                let item = searchItemByCondition.posts[0].items![idx]
                                let itemColor = findItemGradeColor(grade: item.grade!)
                                HStack {
                                    AsyncImage(url: URL(string: item.icon!)) { phash in
                                        if let image = phash.image {
                                            image.ImageModifier()
                                        } else if phash.error != nil {
                                            Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                                        } else {
                                            Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                                        }
                                    }
                                    .multilineTextAlignment(.leading)
                                    .frame(width: w * 0.1)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(itemColor, lineWidth: 2)
                                        .frame(width: w * 0.12))
                                    VStack {
                                        Text(item.name!)
                                            .foregroundColor(itemColor)
                                        HStack{
                                            Text("[구매 시 거래")
                                            Text("\(item.auctionInfo.tradeAllowCount!) 회")
                                                .foregroundColor(.blue)
                                            Text("가능]")
                                        }
                                        if !(item.auctionInfo.buyPrice == nil) {
                                            HStack {
                                                Text("즉시구매가")
                                                Text("\(item.auctionInfo.buyPrice!)")
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                        if !(item.gradeQuality == nil) {
                                            let quailityColor = findItemQualityColor(quaility: item.gradeQuality!)
                                            Text("품질 \(item.gradeQuality!)%")
                                                .foregroundColor(quailityColor)
                                        }
                                        if !( item.auctionInfo.endDate == nil) {
                                            Text("남은시간" + dataFormat(endData: item.auctionInfo.endDate!))
                                        }
                                    }
                                    VStack {
                                        ForEach(item.options.indices , id:\.self) { optionIdx in
                                            if !item.options[optionIdx].isPenalty! {
                                                Text(" \(item.options[optionIdx].optionName!)  \(item.options[optionIdx].value!)")
                                            }
                                        }
                                        ForEach(item.options.indices , id:\.self) { optionIdx in
                                            if item.options[optionIdx].isPenalty! {
                                                Text(" \(item.options[optionIdx].optionName!)  \(item.options[optionIdx].value!)")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                }
                                .frame(height: h * 0.05)
                            }
                        }     .frame(height: h)
                    } else {
                        Text("아이템이 없습니다.")
                    }
                }
                .font(Font.custom("PoorStory-Regular", size: 8, relativeTo: .title))
                .foregroundColor(.gray)
            }
        }
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

func findItemGradeColor(grade: String) -> Color {
    switch grade {
    case "고급" :  return Color.고급
    case "고대" :  return Color.고대
    case "에스더" :  return Color.에스더
    case "영웅" :  return Color.영웅
    case "유물" :  return Color.유물
    case "일반" :  return Color.일반
    case "전설" : return Color.전설
    case "희귀" : return Color.희귀
    default:
        return Color.일반
    }
}

func dataFormat(endData: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    var reEndData = formatter.date(from: endData)
    if (reEndData == nil) {
        reEndData = formatter2.date(from: endData)
    }
    let currentDate = Date()// 1시간 20분 10초
    let remainUTC = reEndData!.timeIntervalSince(currentDate)
    let remainUTCInteger = Int(remainUTC)

    var remainString: String = ""
    if remainUTCInteger.day != 0 {
        remainString += "\(remainUTCInteger.day)일 "
    }
    if remainUTCInteger.hour != 0 {
        remainString += "\(remainUTCInteger.hour)시간 "
    }
    if remainUTCInteger.minute != 0 {
        remainString += "\(remainUTCInteger.minute)분"
    }
    return remainString
}

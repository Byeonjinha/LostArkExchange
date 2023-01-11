//
//  SearcedItemView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/10.
//

import SwiftUI

struct SearcedItemView: View {
    
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    var body: some View {
        ScrollView {
            if !searchItemByCondition.posts.isEmpty {
                Text(String(searchItemByCondition.posts[0].pageSize ?? 0))
                Text(String(searchItemByCondition.posts[0].totalCount!) ?? "")
                if !(searchItemByCondition.posts[0].items == nil) {
                    ForEach(searchItemByCondition.posts[0].items!.indices , id:\.self) { idx in
                        let item = searchItemByCondition.posts[0].items![idx]
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
                            .frame(width: UIScreen.main.bounds.width * 0.1)
                            
                            VStack {
                                Text(item.name!)
                                Text("[구매 시 거래 \(item.auctionInfo.tradeAllowCount!) 회 가능]")
                                if !(item.gradeQuality == nil) {
                                    Text("품질 \(item.gradeQuality!)%")
                                }
                                Text("남은시간" + dataFormat(endData: item.auctionInfo.endDate!))
                            }
                            VStack {
                                ForEach(item.options.indices , id:\.self) { optionIdx in
                                    Text(item.options[optionIdx].optionName!)
                                        .foregroundColor(item.options[optionIdx].isPenalty! ? .red : .black)
                                }
                            }
                        }
                    }
                } else {
                    Text("아이템이 없습니다..")
                }
                Rectangle()
                    .foregroundColor(.red)
            }
        }
    }
}

func dataFormat(endData: String) -> String{
    
    var formatter = DateFormatter()
    
    
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    var endData = formatter.date(from: endData)
    let currentDate = Date()// 1시간 20분 10초
    let remainUTC = endData!.timeIntervalSince(currentDate)
    let remainUTCInteger = Int(remainUTC)
//    print(remainUTCInteger, remainUTCInteger.day, remainUTCInteger.hour, remainUTCInteger.minute)
    
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

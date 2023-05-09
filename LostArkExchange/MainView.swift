//
//  MainView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import AdSupport
import AppTrackingTransparency
import CoreData
import GoogleMobileAds
import SafariServices
import SwiftUI
import WebKit

struct MainView: View {
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    @State private var isSearchItemPresented = false
    
    @State var selectionCategoriesOption: Int = 0
    @State var selectionGradesOption: Int = 0
    @State var selectionGradeQualitiesOption: Int = 0
    @State var selectionTiersOption: Int = 0
    
    @State var searchItemName: String = ""
    @State var urlData: URLData!
    @State var searchItemConditions: SearchItemConditions!
    
    
    @State var searchCharacterName: String = ""
    
    @ObservedObject var viewModel = WebViewModel()
    
    private var noticeURL: String = "https://lostark.game.onstove.com/News/Notice/List"
    
    var body: some View {
        Color.white
            .overlay(
                VStack{
                    TabView {
                        ItemSearchView(
                            searchItemName: $searchItemName,
                            selectionCategoriesOption: $selectionCategoriesOption,
                            selectionGradesOption: $selectionGradesOption,
                            selectionGradeQualitiesOption: $selectionGradeQualitiesOption,
                            selectionTiersOption: $selectionTiersOption,
                            searchItemConditions: $searchItemConditions)
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("아이템 검색")
                        }
                        CharacterSearchView(searchCharacter: $searchCharacterName)
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("캐릭터 검색")
                            }
                        LoaEventsView(urlData: $urlData)
                            .tabItem {
                                Image(systemName: "calendar")
                                Text("이벤트")
                            }
                        let webView = MyWebView(urlToLoad: noticeURL)
                        webView
                            .tabItem {
                                Image(systemName: "doc.plaintext")
                                Text("공지사항")
                            }
                    }
                    GADBannerViewController()
                        .frame(width: GADAdSizeBanner.size.width, height: GADAdSizeBanner.size.height)
                }
            )
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}

struct URLData : Identifiable {
    var id = UUID()
    var url : String
}


struct ItemData : Identifiable {
    var id = UUID()
    var itemData : SearchItems
}


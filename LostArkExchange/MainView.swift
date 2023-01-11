//
//  MainView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import CoreData
import SafariServices
import SwiftUI
import WebKit

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var searchAuctionOptions = AuctionOptionsAPI.shared
    @StateObject private var searchItemByCondition = AuctionItemsAPI.shared
    
    @State private var isSearchItemPresented = false
    
    @State var selectionCategoriesOption: Int = 0
    @State var selectionGradesOption: Int = 0
    @State var selectionGradeQualitiesOption: Int = 0
    @State var selectionTiersOption: Int = 0
    
    @State var searchItemName: String = ""
    @State var urlData: URLData!
    
    @ObservedObject var viewModel = WebViewModel()
    var noticeURL: String = "https://lostark.game.onstove.com/News/Notice/List"
    var body: some View {
        Color.black
            .overlay(
                TabView {
                    ItemSearchView(searchItemName: $searchItemName, selectionCategoriesOption: $selectionCategoriesOption, selectionGradesOption: $selectionGradesOption, selectionGradeQualitiesOption: $selectionGradeQualitiesOption, selectionTiersOption: $selectionTiersOption, isSearchItemPresented: $isSearchItemPresented)
                        .tabItem {
                            Image(systemName: "house")
                            Text("아이템 검색")
                        }
                    LoaEventsView(urlData: $urlData)
                        .tabItem {
                            Image(systemName: "person")
                            Text("이벤트")
                        }
                    let webView = MyWebView(urlToLoad: noticeURL)
                   webView
                        .tabItem {
                            Image(systemName: "bag")
                            Text("공지사항")
                        }
                        .onTapGesture {
                        }
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

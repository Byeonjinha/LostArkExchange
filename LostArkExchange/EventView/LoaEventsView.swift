//
//  LoaEventsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import SwiftUI

struct LoaEventsView: View {
    @StateObject private var searchEvent = EventAPI.shared
    @Binding var urlData: URLData?
    var body: some View {
        if !searchEvent.posts.isEmpty {
            VStack {
                List {
                    ForEach(searchEvent.posts[0].indices , id: \.self) { idx in
                        let title: String = searchEvent.posts[0][idx].title
                        let image: String = searchEvent.posts[0][idx].thumbnail
                        let url: String = searchEvent.posts[0][idx].link
                        
                        Button(action: {
                            self.urlData = URLData(id: UUID(), url: url)
                        }) {
                            EventView(title: title, image: image)
                        }
                        .sheet(item: $urlData)  { item in
                            SafariView(url:URL(string: item.url)!)
                        }
                    }
                }
            }
        }
    }
}

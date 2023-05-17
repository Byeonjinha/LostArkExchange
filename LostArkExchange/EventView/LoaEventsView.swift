import SwiftUI

struct LoaEventsView: View {
    @StateObject private var searchEvent = EventAPI.shared
    @Binding var urlData: URLData?
    
    var body: some View {
        VStack {
            if let posts = searchEvent.posts, !posts.isEmpty {
                List {
                    ForEach(posts[0].indices, id: \.self) { idx in
                        let title: String = posts[0][idx].title
                        let image: String = posts[0][idx].thumbnail
                        let url: String = posts[0][idx].link
                        
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
        .onAppear{
            print(searchEvent.posts)
        }
    }
}

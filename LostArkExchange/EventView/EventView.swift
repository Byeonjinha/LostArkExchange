//
//  EventView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/04.
//

import SwiftUI

struct EventView: View {
    
    let title: String
    let image: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: image)) { phash in
                if let image = phash.image {
                    image.ImageModifier()
                } else if phash.error != nil {
                    Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                } else {
                    Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                }
            }
            .multilineTextAlignment(.leading)
            .frame(width: UIScreen.main.bounds.width * 0.3)
            
            Text(title)
        }
    }
}

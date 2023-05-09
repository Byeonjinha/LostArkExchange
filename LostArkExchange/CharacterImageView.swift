//
//  CharacterImageView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/25.
//

import SwiftUI

struct CharacterImageView: View {
    
    var characterImage: String
    var expeditionLevel: String
    var itemMaxLevel: String
    var characterClassName: String
    var serverName: String
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: characterImage)) { phash in
                if let image = phash.image {
                    image.ImageModifier()
                } else if phash.error != nil {
                    Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                        .frame(width: w * 0.3)
                } else {
                    Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                        .multilineTextAlignment(.leading)
                        .frame(width: w * 0.3)
                }
            }
            .multilineTextAlignment(.leading)
            .frame(width: w * 0.1)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.defaultBlue, lineWidth: 2)
                .frame(width: w * 0.12))
            .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("서버: \(serverName)")
                    Text("클래스: \(characterClassName)")
                }
                VStack(alignment: .leading) {
                    Text("탐험 레벨: \(expeditionLevel)")
                    Text("아이템 레벨: \(itemMaxLevel)")
                }
            }
            
            Spacer()
        }
    }
}

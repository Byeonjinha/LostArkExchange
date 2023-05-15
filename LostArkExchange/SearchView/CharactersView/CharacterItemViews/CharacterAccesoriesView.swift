//
//  CharacterAccesoriesView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/09.
//

import SwiftUI

struct CharacterAccesoriesView: View {
    var findAccessoriesElements: [[String]]
    var accessoriesArray: [String]
    @Binding var isEquipmentsViewStatus: Int
    @Binding var accessories: AccessoriesViewData

    var body: some View {
        ForEach(findAccessoriesElements, id: \.self) {accessoriesElement in
            let accessories: AccessoriesViewData = makeAccessories(element: accessoriesElement)
            if accessoriesArray.contains(accessoriesElement[0]) {
                HStack {
                    AsyncImage(url: URL(string: accessories.image)) { phash in
                        if let image = phash.image {
                            image.ImageModifier()
                        } else if phash.error != nil {
                            Image(systemName: "exclamationmark.icloud.fill").IconModifier().foregroundColor(.red)
                                .multilineTextAlignment(.leading)
                                .frame(width: w * 0.05)
                        } else {
                            Image(systemName: "photo.circle.fill").IconModifier().foregroundColor(.clear)
                                .multilineTextAlignment(.leading)
                                .frame(width: w * 0.05)
                        }
                    }
                    .multilineTextAlignment(.leading)
                    .frame(width: w * 0.05)
                    HStack {
                        Text("\(accessories.name)")
                            .foregroundColor(accessories.gradeColor)

                        Text("[\(accessories.quality)]")
                            .foregroundColor(accessories.qualityColor)
                    }

                }
                .onTapGesture(perform: {
                    self.isEquipmentsViewStatus = 3
                    self.accessories = accessories
                })
            }
        }
    }
}

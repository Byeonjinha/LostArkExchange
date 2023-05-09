//
//  EtcOptionsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/09.
//

import SwiftUI

struct EtcOptionsView: View {
    @Binding var etcOptions: [SelectionEtcOptions]
    
    var body: some View {
        HStack {
            Text("기타 옵션")
            Button(action: {
                self.etcOptions.append(SelectionEtcOptions(etcOptionValue: 0, etcSubValue: 0, minValue: ""))
                
            })  {
                Rectangle()
                    .frame(width: w*0.05)
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.blue)

                    )
            }
        }
        ForEach(etcOptions.indices , id: \.self) {idx in
            HStack {
                ItemEtcOptionsView(etcOptions: $etcOptions, idx: idx)
            }
        }
    }
}

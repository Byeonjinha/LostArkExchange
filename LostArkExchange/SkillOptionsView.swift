//
//  SkillOptionsView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/09.
//

import SwiftUI

struct SkillOptionsView: View {
    @Binding var skillOptions: [SelectionSkillOptions]
    @Binding var classIdx: Int
    var body: some View {
        HStack {
            Text("스킬 옵션")
            Button(action: {
                self.skillOptions.append(SelectionSkillOptions(SkillOptionValue: 0, TripodValue: 0, minValue: ""))
                
            }) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width*0.05)
                    .foregroundColor(.clear)
                    .overlay(
                        Image(systemName: "plus")
                    )
            }
        }
        ForEach(skillOptions.indices , id: \.self) {idx in
            HStack {
                ItemSkillOptionsView(skillOptions: $skillOptions, classIdx: $classIdx, idx: idx)
            }
        }
    }
}

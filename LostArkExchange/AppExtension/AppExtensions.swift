//
//  AppExtensions.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

extension Image {
    func ImageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func IconModifier() -> some View {
        self
            .ImageModifier()
            .frame(maxWidth: 200)
            .opacity(0.6)
    }
}

extension Int {
    var day: Int {
        self / 86400
    }
    var hour: Int {
        (self % 86400) / 3600
    }
    var minute: Int {
        (self % 3600) / 60
    }
    var seconds: Int {
        (self % 60)
    }
}

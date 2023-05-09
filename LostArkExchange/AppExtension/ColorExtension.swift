//
//  ColorExtension.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/11.
//

import SwiftUI

extension Color {
    //Item Grade QuailityColors
    static let qualitiy0 = Color("qualitiy0")
    static let qualitiy1to9 = Color("qualitiy1to9")
    static let qualitiy10to29 = Color("qualitiy10to29")
    static let qualitiy30to69 = Color("qualitiy30to69")
    static let qualitiy70to89 = Color("qualitiy70to89")
    static let qualitiy90to99 = Color("qualitiy90to99")
    static let qualitiy100 = Color("qualitiy100")
    
    //Item GradeColors
    static let 고급 = Color("고급")
    static let 고대 = Color("고대")
    static let 에스더 = Color("에스더")
    static let 영웅 = Color("영웅")
    static let 유물 = Color("유물")
    static let 일반 = Color("일반")
    static let 전설 = Color("전설")
    static let 희귀 = Color("희귀")
    
    static let defaultBlue = Color("defaultBlue")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

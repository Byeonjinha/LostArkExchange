//
//  AppExtensions.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import SwiftUI

let w = UIScreen.main.bounds.width
let h = UIScreen.main.bounds.height

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

extension String {
    func htmlToString() -> String {
        return  try! NSAttributedString(data: self.data(using: .unicode)!,
                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                        documentAttributes: nil).string
    }
}

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        return String(self[startIndex ..< endIndex])
    }
}

func findItemQualityColor(quaility: Int) -> Color {
    switch quaility {
    case let x where x == 0:  return Color.qualitiy0
    case let x where 1 <= x && x <= 9:  return Color.qualitiy1to9
    case let x where 10 <= x && x <= 29:  return Color.qualitiy10to29
    case let x where 30 <= x && x <= 69:  return Color.qualitiy30to69
    case let x where 70 <= x && x <= 89:  return Color.qualitiy70to89
    case let x where 90 <= x && x <= 99:  return Color.qualitiy90to99
    case let x where x == 100 : return Color.qualitiy100
    default:
        return Color.white
    }
}

extension ItemConditionEntity {
    func populate(conditionName: String, itemName: String, itemGrade: String, categoryCode: Int, itemGradeQuality: String, itemTier: Int, etcOptions: String, skillOptions: String) {
        self.conditionName = conditionName
        self.itemName = itemName
        self.itemGrade = itemGrade
        self.categoryCode = Int64(categoryCode)
        self.itemGradeQuality = itemGradeQuality
        self.itemTier = Int64(itemTier)
        self.etcOptions = etcOptions
        self.skillOptions = skillOptions
        self.timestamp = Date()
    }
}

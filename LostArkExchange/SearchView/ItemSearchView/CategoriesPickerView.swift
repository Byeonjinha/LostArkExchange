//
//  CategoriesPickerView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import Combine
import SwiftUI
import UIKit

var bindingUpdate:()->Void={}

struct CategoriesPickerView: UIViewRepresentable {
    @Binding var choicedCategorie: Int
    @Binding var choicedGrade: Int
    @Binding var itemGradeQuality: Int
    @Binding var itemTier: Int
   
    
    let categories: [(Int, String)]?
    let itemGrades: [String]?
    let itemGradeQualities: [Int]?
    let itemTiers: [Int]
    
    @ObservedObject var pickerView = CategoriesUIPickerView(categories: [(0, "A")], itemGrades: ["A"], itemGradeQualities: [0], itemTiers: [0])
    
    func makeUIView(context: Context) -> UIPickerView {
        bindingUpdate={
            self.choicedCategorie = pickerView.choicedCategorie ?? 0
            self.choicedGrade = pickerView.choicedGrade ?? 0
            self.itemGradeQuality = pickerView.itemGradeQuality ?? 0
            self.itemTier = pickerView.itemTier ?? 0
        }
        return pickerView
    }
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        pickerView.categories = self.categories
        pickerView.itemGrades = self.itemGrades
        pickerView.itemGradeQualities = self.itemGradeQualities
        pickerView.itemTiers = self.itemTiers
        
        pickerView.delegate = pickerView.self
        pickerView.dataSource = pickerView.self  
    }
}

class CategoriesUIPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource, ObservableObject {
    
    @Published var choicedCategorie: Int?
    @Published var choicedGrade: Int?
    @Published var itemGradeQuality: Int?
    @Published var itemTier: Int?
    
    var labelTexts = ["카테고리", "등급", "품질", "티어"]
    var categories: [(Int, String)]?
    var itemGrades: [String]?
    var itemGradeQualities: [Int]?
    var itemTiers: [Int]?
    
    let labelStartLocation: [Double] = [0, 0.28, 0.44, 0.58]
    let labelWidth: [Double] = [0.28, 0.16, 0.14, 0.14]
    init(categories: [(Int, String)], itemGrades: [String], itemGradeQualities: [Int], itemTiers: [Int]) {
        self.categories = categories
        self.itemGrades = itemGrades
        self.itemGradeQualities = itemGradeQualities
        self.itemTiers = itemTiers
        
        super.init(frame: .zero)
        for index in 0..<labelTexts.count {
            let label: UILabel = UILabel.init(frame: CGRectMake(w * 0.03 + w * labelStartLocation[index], 0,  w * labelWidth[index], 20))
            label.text = labelTexts[index]
            label.font = UIFont(name: "ArialHebrew", size: UIFont.labelFontSize)
            label.textAlignment = .center
            self.addSubview(label)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0 :
            return categories!.count
        case 1 :
            return itemGrades!.count
        case 2 :
            return itemGradeQualities!.count + 2
        case 3 :
            return itemTiers!.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var searchingItemData: String?
        switch component {
        case 0 :
            searchingItemData = categories![row].1
        case 1 :
            searchingItemData = itemGrades![row]
        case 2 :
            if itemGradeQualities!.count > row {
                searchingItemData = String(itemGradeQualities![row]) }
            else if itemGradeQualities!.count == row {
                searchingItemData = "100"
            } else {
                searchingItemData = "없음"
            }
        case 3 :
            searchingItemData = String(itemTiers![row])
        default:
            searchingItemData =  ""
        }
        let pickerLabel: UILabel
        
        if let label = view as? UILabel {
            pickerLabel = label
        } else {
            pickerLabel = UILabel()
            // Customize text
            pickerLabel.font = pickerLabel.font.withSize(14)
            pickerLabel.textAlignment = .left
            pickerLabel.textColor = UIColor.secondaryLabel
            // Create a paragraph with custom style
            // We only need indents to prevent text from being cut off
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = 12 // May vary
            // Create a string and append style to it
            let attributedString = NSMutableAttributedString(string: searchingItemData!)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            // Update label's text
            pickerLabel.attributedText = attributedString
        }
        
        return pickerLabel
    }
    
    // A method called when the picker is selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0 :
            self.choicedCategorie = row
        case 1 :
            self.choicedGrade = row
        case 2 :
            self.itemGradeQuality = row
        case 3 :
            self.itemTier = row
        default:
            break
        }
        bindingUpdate()
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 0 :
            let labelWidth = w * 0.28
            return labelWidth
        case 1 :
            return w * 0.16
        case 2 :
            return w * 0.14
        case 3 :
            return w * 0.14
        default:
            return 0
        }
    }
}

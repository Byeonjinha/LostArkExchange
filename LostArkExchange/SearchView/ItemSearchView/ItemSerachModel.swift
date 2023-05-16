//
//  ItemSerachModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/05/15.
//

import Foundation

struct SelectionEtcOptions {
    var etcOptionValue: Int
    var etcSubValue: Int
    var minValue: String
}

struct SelectionSkillOptions {
    var SkillOptionValue: Int
    var TripodValue: Int
    var minValue: String
}

struct SearchItemConditions: Identifiable {
    var id = UUID()
    var searchItemName: String
    var selectionGradesOption: String
    var selectionCategoriesOption: Int
    var itemGradeQuality: String
    var selectionTiersOption: Int
    var strEtcOptions: String
    var strSkillOptions: String
}

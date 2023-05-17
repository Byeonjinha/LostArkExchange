//
//  WebViewViewModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    @Published private var isSearchItemPresented = false
    @Published var selectionOptions:SelectionOptions = SelectionOptions(categories: 0,
                                                                        grades: 0,
                                                                        gradeQualities: 0,
                                                                        tiers: 0,
                                                                        itemName: "",
                                                                        characterName: "",
                                                                        itemGradeQualities: "",
                                                                        strEtcOptions: "",
                                                                        strSkillOptions: "")
    @Published var urlData: URLData!
    @Published var searchItemConditions: SearchItemConditions!
    
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}



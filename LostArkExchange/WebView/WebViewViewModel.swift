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
    @Published var selectionOptions: (categories: Int,
                                      grades: Int,
                                      gradeQualities: Int,
                                      tiers: Int,
                                      itemName: String,
                                      characterName: String) = (0, 0, 0, 0, "", "")
    @Published var urlData: URLData!
    @Published var searchItemConditions: SearchItemConditions!
    
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}




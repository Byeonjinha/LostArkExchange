//
//  WebViewViewModel.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/07.
//

import Foundation
import Combine

class WebViewModel: ObservableObject {
    var foo = PassthroughSubject<Bool, Never>()
    var bar = PassthroughSubject<Bool, Never>()
}

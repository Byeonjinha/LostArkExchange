//
//  HTMLView.swift
//  LostArkExchange
//
//  Created by Byeon jinha on 2023/01/26.
//

import SwiftUI

struct HTMLView: UIViewRepresentable {
    let html: String
    let isScrollEnabled: Bool
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
        DispatchQueue.main.async {
            let addCss = "<head><style>" +
        """
          @font-face {
            font-family: "사용할폰트";
          }
        
          body {
            font-family: "사용할폰트";
            color: White;
            line-height: 1.0;
          }
        """
            + " </style></head>" + "<body>" + html + "</body>"
            let data = Data(addCss.utf8)
            if let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil)
            {
                uiView.isEditable = false
                uiView.attributedText = attributedString
            }
        }
    }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UITextView {
        let uiTextView = UITextView()
        uiTextView.backgroundColor = .clear
        uiTextView.isScrollEnabled = isScrollEnabled
        return uiTextView
    }
}

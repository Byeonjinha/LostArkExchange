# LostArkExchange
발전을 위해 남기는 리펙토링 기록

**거래소 내 아이템 시세 조회 및 캐릭터의 정보를 제공하는 앱**

------------------------
<img src="https://github.com/Byeonjinha/LostArkExchange/assets/87685946/ba3f2f11-7352-4bec-8f9d-c8b3d6f37d7b" width="30%" height="30%"/>
<img src="https://github.com/Byeonjinha/LostArkExchange/assets/87685946/2c5711db-100f-472e-80e6-3719a6b9bc24" width="30%" height="30%"/>
<img src="https://github.com/Byeonjinha/LostArkExchange/assets/87685946/2cb375bb-32d2-4bb9-a998-47b7afa4c071" width="30%" height="30%"/>

## 🔗App Store : [LostArkExchange](https://apps.apple.com/app/loastark/id1664763926)

------------------------
## ✨ Skills & Tech Stack
SwiftUI, UIKit

## 🛠 Development Environment
------------------------
iOS: 15.1+,  Xcode: 14.1

## 기술적 도전
------------------------
HTML을 활용해  iOS에서 뷰 생성
 ![image](https://github.com/Byeonjinha/LostArkExchange/assets/87685946/6564458b-e8c8-44fc-b9b8-53db9935d8bf)

```Swift
import SwiftUI

struct HTMLView: UIViewRepresentable {
    let html: String
    let isScrollEnabled: Bool
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<Self>) {
        DispatchQueue.main.async {
            let addCss = "<head><style>" +
        """
          @font-face {
            font-family: "font";
          }
          body {
            font-family: "font";
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
                uiView.textAlignment = .center
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

```

UIPickerView Custom


<img width="275" alt="image" src="https://github.com/Byeonjinha/LostArkExchange/assets/87685946/7c18f482-9153-4a9e-83fb-2f758dca12d9">

```Swift
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

```
## License
------------------------
[MIT](https://choosealicense.com/licenses/mit/)

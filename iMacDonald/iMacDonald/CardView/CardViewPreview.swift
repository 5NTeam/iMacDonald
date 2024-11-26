//
//  CardViewPreview.swift
//  iMacDonald
//
//  Created by Hwangseokbeom on 11/26/24.
//

import SwiftUI

struct CardViewPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> CardView {
        // 임시 데이터로 CardView 생성
        let cardView = CardView(name: "치즈버거", price: 4000, image: UIImage(systemName: "cheeseburger"))
        return cardView
    }

    func updateUIView(_ uiView: CardView, context: Context) {
        // 필요 시 업데이트 처리
    }
}

// SwiftUI Preview
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardViewPreview()
            .frame(width: 200, height: 300) // 원하는 크기로 설정
            .previewLayout(.sizeThatFits)
    }
}

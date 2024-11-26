//
//  CardView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//

import UIKit
import SnapKit
class CardView {
    
    static func createCardView(title: String, price: Int, image: UIImage?) -> UIView {
        // 카드뷰 생성
        let cardView = UIView()
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.backgroundColor = .white
     
        return cardView
    }
}

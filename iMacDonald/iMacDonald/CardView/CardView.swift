//
//  CardView1.swift
//  iMacDonald
//
//  Created by Hwangseokbeom on 11/26/24.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let button = UIButton()
    
    // 메뉴 이름, 가격, 이미지, 카테고리를 가지는 객체 생성하고 초기화
    init(title: String, price: Int, image: UIImage?, category: Categorys) {
        super.init(frame: .zero)
        setupView() // 뷰
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 카드 뷰 UI 설정
    private func setupView() {
        
    }
    
}

//
//  CardView1.swift
//  iMacDonald
//
//  Created by Hwangseokbeom on 11/26/24.
//

import UIKit
import SnapKit

class CardView: UIView {
    
    // CardView의 구성요소 이미지, 레이블 2개, 버튼 1개 객체 생성
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
        // 카드뷰 스타일 설정
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.backgroundColor = .white
        
        // 이미지뷰 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        addSubview(imageView)
        
        // 메뉴이름 레이블 설정
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0 // 여러 줄로 표시 가능
        titleLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        addSubview(titleLabel)
        
        // 가격 레이블 설정
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .darkGray
        addSubview(priceLabel)
        
        // 버튼 설정
        let buttonImage = UIImage(systemName: "plus.circle.fill")
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "PersonalColor")
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
    }
    
    
}

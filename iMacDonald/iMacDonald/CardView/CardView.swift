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
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let button = UIButton()
    
    // 메뉴 이름, 가격, 이미지를 가지는 객체 생성하고 초기화
    init(name: String, price: Int, image: UIImage?) {
        super.init(frame: .zero)
        setupView() // 뷰
        configure(name: name, price: price, image: image) // 데이터 바인딩 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 카드 뷰 UI 설정
    private func setupView() {
        // 카드뷰 스타일 설정
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.backgroundColor = .white
        
        // 이미지뷰 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        addSubview(imageView)
        
        // 메뉴이름 레이블 설정
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0 // 여러 줄로 표시 가능
        nameLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        addSubview(nameLabel)
        
        // 가격 레이블 설정
        priceLabel.font = UIFont.systemFont(ofSize: 20)
        priceLabel.textColor = .darkGray
        addSubview(priceLabel)
        
        // 버튼 설정
        let buttonImage = UIImage(systemName: "plus.circle.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large))
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "PersonalColor")
        //button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
        // 제약 조건 설정
        setupConstraints()
        
    }
    
    // 카드뷰의 요소 이미지뷰, 메뉴이름, 가격, 버튼 제약 조건 설정 메서드
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6) // 이미지뷰 높이: 카드뷰 높이의 60%
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10) // 버튼과 겹치지 않도록 설정
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10) // 버튼과 겹치지 않도록 설정
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }

        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20) // 카드뷰 오른쪽에서 20pt
            make.bottom.equalToSuperview().offset(-10) // 카드뷰 아래에서 10pt
            make.width.equalToSuperview().multipliedBy(0.3) // 카드뷰 너비의 30%
            make.height.equalToSuperview().multipliedBy(0.3) // 카드뷰 높이의 30%
        }
    }
    
    // 데이터 바인딩해주는 메서드
    private func configure(name: String, price: Int, image: UIImage?) {
        nameLabel.text = name
        priceLabel.text = "\(price)원"
        imageView.image = image
    }
    
}

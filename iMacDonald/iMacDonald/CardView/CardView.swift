//
//  CardView.swift
//  iMacDonald
//
//  Created by 황석범 on 11/26/24.
//

import UIKit
import SnapKit

class CardView {
    
    static func createCardView(title: String, price: Int, image: UIImage?, category: Categorys) -> UIView {
        // 카드뷰 생성
        let cardView = UIView()
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.backgroundColor = .white
        
        // 이미지뷰 추가
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cardView.addSubview(imageView)
        
        // 라벨 추가
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0 // 줄바꿈 허용
        titleLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        titleLabel.textColor = .black
        cardView.addSubview(titleLabel)
        
        let priceLabel = UILabel()
        priceLabel.text = title
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel.textColor = .black
        cardView.addSubview(priceLabel)
        
        // 버튼 추가
        let button = UIButton()
        let buttonImage = UIImage(systemName: "plus.circle.fill") // 아이콘 설정
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "PersonalColor")
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchDown)
        cardView.addSubview(button)
        
        
        // 카드뷰에 들어가는 이미지뷰, 메뉴이름, 가격, 버튼, 제약조건 설정
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6) // 이미지뷰는 top, leading, trailing가 카드뷰와 같게, 높이는 카드뷰의 0.6
         }
      
         titleLabel.snp.makeConstraints { make in
             make.top.equalTo(imageView.snp.bottom).offset(10)
             make.leading.equalToSuperview().offset(10)
             make.trailing.equalToSuperview().offset(-50) // 버튼 고려
             make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
      
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-50) // 버튼 고려
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
      
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(priceLabel.snp.centerY) // 라벨과 정렬
            make.width.height.equalTo(30) // 버튼 크기
        }
        
        return cardView
    
    }
    // 버튼 클릭 시 동작 예시
    @objc private func buttonTapped(_ sender: UIButton) {        
    }

}

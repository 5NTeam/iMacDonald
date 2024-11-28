//
//  MenuTableViewCell.swift
//  iMacDonald
//
//  Created by 손겸 on 11/26/24.
//

import UIKit
import SnapKit


class MenuTableViewCell: UITableViewCell {
    // UI 요소
    let menuImageView = UIImageView() // 이미지
    let nameLabel = UILabel() // 메뉴 이름
    let priceLabel = UILabel() // 가격
    let decreaseButton = UIButton() // 수량 감소 버튼
    let quantityLabel = UILabel() // 수량
    let increaseButton = UIButton() // 수량 증가 버튼
    let deleteButton = UIButton() // 삭제 버튼
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // 셀의 UI를 설정하는 커스텀 메서드
    }
    // 이건 위에 초기화 하니까 써야한다고 xcode상에서 fix해줌
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupUI() {
        // 메뉴 이미지 뷰
        contentView.addSubview(menuImageView)
        menuImageView.layer.cornerRadius = 8
        menuImageView.clipsToBounds = true
        menuImageView.backgroundColor = .side
        menuImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        // 메뉴 이름 라벨
        contentView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.text = "메뉴이름"
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(menuImageView.snp.top).offset(3.5)
            make.leading.equalTo(menuImageView.snp.trailing).offset(12)
        }
        
        // 가격 라벨
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.textColor = .tableViewPrice
        priceLabel.text = "16000원"
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }
        
        // 스택뷰
        let buttonStackView = UIStackView(arrangedSubviews: [decreaseButton, quantityLabel, increaseButton, deleteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.alignment = .center
        contentView.addSubview(buttonStackView)
        
        // 스택뷰 제약
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        
        // 수량 감소 버튼
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.layer.cornerRadius = 16
        decreaseButton.backgroundColor = .side
        decreaseButton.layer.shadowColor = UIColor.count.cgColor
        decreaseButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        decreaseButton.layer.shadowOpacity = 0.2
        decreaseButton.layer.shadowRadius = 1
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-140)
            make.width.height.equalTo(32)
        }
        
        // 수량 라벨
        quantityLabel.font = .systemFont(ofSize: 13)
        quantityLabel.textAlignment = .center
        quantityLabel.text = "1"
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(decreaseButton.snp.trailing).offset(18)
            make.width.equalTo(20)
        }
        
        // 수량 증가 버튼
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.layer.cornerRadius = 16
        increaseButton.backgroundColor = .side
        increaseButton.layer.shadowColor = UIColor.count.cgColor
        increaseButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        increaseButton.layer.shadowOpacity = 0.2
        increaseButton.layer.shadowRadius = 1
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantityLabel.snp.trailing).offset(18)
            make.width.equalTo(32)
        }
        
        // 삭제 버튼
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .personal
        deleteButton.layer.cornerRadius = 16
        deleteButton.backgroundColor = .side
        deleteButton.layer.shadowColor = UIColor.count.cgColor
        deleteButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        deleteButton.layer.shadowOpacity = 0.2
        deleteButton.layer.shadowRadius = 1
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(increaseButton.snp.trailing).offset(25)
            make.width.height.equalTo(32)
        }
    }
}

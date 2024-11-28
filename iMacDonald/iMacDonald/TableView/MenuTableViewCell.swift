//
//  MenuTableViewCell.swift
//  iMacDonald
//
//  Created by 손겸 on 11/26/24.
//
//  메뉴 아이템을 표시하는 테이블뷰 셀을 구현한 파일입니다.
//  각 셀은 메뉴 이미지, 이름, 가격, 수량 조절 버튼, 삭제 버튼을 포함합니다.

import UIKit
import SnapKit

/// 메뉴 아이템을 표시하기 위한 커스텀 테이블뷰 셀 클래스
class MenuTableViewCell: UITableViewCell {
    // MARK: - UI Components
    /// 메뉴 이미지를 표시하는 이미지뷰
    let menuImageView = UIImageView()
    
    /// 메뉴 이름을 표시하는 레이블
    let nameLabel = UILabel()
    
    /// 메뉴 가격을 표시하는 레이블
    let priceLabel = UILabel()
    
    /// 수량을 감소시키는 버튼
    let decreaseButton = UIButton()
    
    /// 현재 선택된 수량을 표시하는 레이블
    let quantityLabel = UILabel()
    
    /// 수량을 증가시키는 버튼
    let increaseButton = UIButton()
    
    /// 메뉴 아이템을 삭제하는 버튼
    let deleteButton = UIButton()
    
    // MARK: - Initialization
    /// 셀의 기본 초기화 메서드
    /// - Parameters:
    ///   - style: 셀의 스타일
    ///   - reuseIdentifier: 재사용 식별자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // UI 구성요소 초기화 및 설정
    }
    
    /// required initializer (스토리보드 지원을 위한 필수 구현)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Setup
    /// UI 구성요소들의 레이아웃과 스타일을 설정하는 private 메서드
    private func setupUI() {
        // 메뉴 이미지뷰 설정
        contentView.addSubview(menuImageView)
        menuImageView.layer.cornerRadius = 8 // 둥근 모서리 설정
        menuImageView.clipsToBounds = true // 이미지가 경계를 벗어나지 않도록 설정
        menuImageView.backgroundColor = .side
        menuImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        // 메뉴 이름 레이블 설정
        contentView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.text = "메뉴이름"
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(menuImageView.snp.top).offset(3.5)
            make.leading.equalTo(menuImageView.snp.trailing).offset(12)
        }
        
        // 가격 레이블 설정
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.textColor = .tableViewPrice
        priceLabel.text = "16000원"
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }
        
        // 버튼들을 포함하는 스택뷰 설정
        let buttonStackView = UIStackView(arrangedSubviews: [decreaseButton, quantityLabel, increaseButton, deleteButton])
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.alignment = .center
        contentView.addSubview(buttonStackView)
        
        // 스택뷰 제약조건 설정
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        
        // 수량 감소 버튼 설정
        setupDecreaseButton()
        
        // 수량 레이블 설정
        setupQuantityLabel()
        
        // 수량 증가 버튼 설정
        setupIncreaseButton()
        
        // 삭제 버튼 설정
        setupDeleteButton()
    }
    
    // MARK: - Private Button Setup Methods
    /// 수량 감소 버튼 설정
    private func setupDecreaseButton() {
        decreaseButton.setTitle("-", for: .normal)
        decreaseButton.setTitleColor(.black, for: .normal)
        decreaseButton.layer.cornerRadius = 16
        decreaseButton.backgroundColor = .side
        setupButtonShadow(for: decreaseButton)
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-140)
            make.width.height.equalTo(32)
        }
    }
    
    /// 수량 레이블 설정
    private func setupQuantityLabel() {
        quantityLabel.font = .systemFont(ofSize: 13)
        quantityLabel.textAlignment = .center
        quantityLabel.text = "1"
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(decreaseButton.snp.trailing).offset(18)
            make.width.equalTo(20)
        }
    }
    
    /// 수량 증가 버튼 설정
    private func setupIncreaseButton() {
        increaseButton.setTitle("+", for: .normal)
        increaseButton.setTitleColor(.black, for: .normal)
        increaseButton.layer.cornerRadius = 16
        increaseButton.backgroundColor = .side
        setupButtonShadow(for: increaseButton)
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantityLabel.snp.trailing).offset(18)
            make.width.equalTo(32)
        }
    }
    
    /// 삭제 버튼 설정
    private func setupDeleteButton() {
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .personal
        deleteButton.layer.cornerRadius = 16
        deleteButton.backgroundColor = .side
        setupButtonShadow(for: deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(increaseButton.snp.trailing).offset(25)
            make.width.height.equalTo(32)
        }
    }
    
    /// 버튼에 그림자 효과 추가
    /// - Parameter button: 그림자를 추가할 버튼
    private func setupButtonShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.count.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 1
    }
}

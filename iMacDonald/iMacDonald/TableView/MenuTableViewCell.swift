//
//  MenuTableViewCell.swift
//  iMacDonald
//
//  Created by 손겸 on 11/26/24.
//
//  맥도날드 앱의 장바구니 화면에서 사용되는 메뉴 아이템 셀을 구현한 파일입니다.
//  이 셀은 메뉴의 이미지, 이름, 가격 정보를 표시하고,
//  수량 조절(+/- 버튼)과 삭제 기능을 제공하는 사용자 인터페이스를 포함합니다.
//  SnapKit을 사용하여 오토레이아웃을 구현했습니다.

import UIKit
import SnapKit

/// 장바구니의 각 메뉴 아이템을 표시하기 위한 커스텀 테이블뷰 셀
/// 메뉴의 기본 정보 표시와 수량 조절, 삭제 기능을 제공합니다.
class MenuTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    /// 메뉴의 이미지를 표시하는 이미지뷰
    /// 48x48 크기의 정사각형으로, 둥근 모서리(radius 8)를 가집니다.
    let menuImageView = UIImageView()
    
    /// 메뉴의 이름을 표시하는 레이블
    /// 18pt 크기의 medium 웨이트 시스템 폰트를 사용합니다.
    let nameLabel = UILabel()
    
    /// 메뉴의 가격을 표시하는 레이블
    /// 13pt 크기의 시스템 폰트를 사용하며, tableViewPrice 색상으로 표시됩니다.
    let priceLabel = UILabel()
    
    /// 메뉴 수량을 감소시키는 버튼
    /// "-" 텍스트를 표시하며, 32x32 크기의 원형 버튼입니다.
    let decreaseButton = UIButton()
    
    /// 현재 선택된 메뉴의 수량을 표시하는 레이블
    /// 13pt 크기의 시스템 폰트를 사용하며, 중앙 정렬됩니다.
    let quantityLabel = UILabel()
    
    /// 메뉴 수량을 증가시키는 버튼
    /// "+" 텍스트를 표시하며, 32x32 크기의 원형 버튼입니다.
    let increaseButton = UIButton()
    
    /// 메뉴 항목을 삭제하는 버튼
    /// 휴지통 아이콘을 표시하며, 32x32 크기의 원형 버튼입니다.
    let deleteButton = UIButton()
    
    // MARK: - Initialization
    /// 셀의 기본 초기화 메서드
    /// 스토리보드를 사용하지 않고 코드로 셀을 생성할 때 호출됩니다.
    /// - Parameters:
    ///   - style: 셀의 기본 스타일을 지정하는 UITableViewCell.CellStyle 값
    ///   - reuseIdentifier: 셀 재사용을 위한 식별자 문자열
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI() // UI 컴포넌트들의 초기 설정 수행
    }
    
    /// 스토리보드로부터 셀을 생성할 때 사용되는 필수 초기화 메서드
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI Setup
    /// 셀의 모든 UI 컴포넌트들을 초기화하고 레이아웃을 설정하는 메서드
    /// 각 UI 요소들의 제약조건과 스타일을 지정합니다.
    private func setupUI() {
        // 메뉴 이미지뷰 설정
        contentView.addSubview(menuImageView)
        menuImageView.layer.cornerRadius = 8  // 모서리 둥글게 처리
        menuImageView.clipsToBounds = true    // 이미지가 둥근 모서리 밖으로 나가지 않도록 설정
        menuImageView.backgroundColor = .side  // 기본 배경색 설정
        // 이미지뷰 제약조건 설정: 왼쪽 여백 16, 중앙 정렬, 48x48 크기
        menuImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        // 메뉴 이름 레이블 설정
        contentView.addSubview(nameLabel)
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)  // 폰트 설정
        nameLabel.text = "메뉴이름"  // 기본 텍스트 설정
        // 이름 레이블 제약조건: 이미지뷰 위에서 3.5pt 떨어진 위치, 이미지뷰 오른쪽에서 12pt 떨어짐
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(menuImageView.snp.top).offset(3.5)
            make.leading.equalTo(menuImageView.snp.trailing).offset(12)
        }
        
        // 가격 레이블 설정
        contentView.addSubview(priceLabel)
        priceLabel.font = .systemFont(ofSize: 13)  // 폰트 설정
        priceLabel.textColor = .tableViewPrice     // 텍스트 색상 설정
        priceLabel.text = "16000원"                // 기본 텍스트 설정
        // 가격 레이블 제약조건: 이름 레이블 아래 5pt, 같은 leading 정렬
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.leading.equalTo(nameLabel)
        }
        
        // 버튼들을 포함하는 수평 스택뷰 설정
        let buttonStackView = UIStackView(arrangedSubviews: [decreaseButton, quantityLabel, increaseButton, deleteButton])
        buttonStackView.axis = .horizontal       // 수평 방향 스택뷰
        buttonStackView.spacing = 20             // 버튼 사이 간격 20pt
        buttonStackView.alignment = .center      // 중앙 정렬
        contentView.addSubview(buttonStackView)
        
        // 스택뷰 제약조건: 셀 중앙에 위치, 오른쪽 여백 30pt
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
        }
        
        // 각 버튼 컴포넌트 설정
        setupDecreaseButton()  // 감소 버튼
        setupQuantityLabel()   // 수량 레이블
        setupIncreaseButton()  // 증가 버튼
        setupDeleteButton()    // 삭제 버튼
    }
    
    // MARK: - Private Button Setup Methods
    /// 수량 감소 버튼의 UI를 설정하는 메서드
    /// 원형 버튼으로 설정하고 그림자 효과를 추가합니다.
    private func setupDecreaseButton() {
        decreaseButton.setTitle("-", for: .normal)           // 마이너스 텍스트 설정
        decreaseButton.setTitleColor(.black, for: .normal)   // 텍스트 색상 검정
        decreaseButton.layer.cornerRadius = 16               // 원형 모양을 위한 설정
        decreaseButton.backgroundColor = .side               // 배경색 설정
        setupButtonShadow(for: decreaseButton)              // 그림자 효과 추가
        // 버튼 제약조건: 중앙 정렬, 오른쪽에서 140pt, 32x32 크기
        decreaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-140)
            make.width.height.equalTo(32)
        }
    }
    
    /// 수량 표시 레이블의 UI를 설정하는 메서드
    private func setupQuantityLabel() {
        quantityLabel.font = .systemFont(ofSize: 13)     // 13pt 크기 폰트
        quantityLabel.textAlignment = .center            // 텍스트 중앙 정렬
        quantityLabel.text = "1"                         // 기본값 1 설정
        // 레이블 제약조건: 중앙 정렬, 감소 버튼 오른쪽 18pt, 너비 20pt
        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(decreaseButton.snp.trailing).offset(18)
            make.width.equalTo(20)
        }
    }
    
    /// 수량 증가 버튼의 UI를 설정하는 메서드
    /// 원형 버튼으로 설정하고 그림자 효과를 추가합니다.
    private func setupIncreaseButton() {
        increaseButton.setTitle("+", for: .normal)          // 플러스 텍스트 설정
        increaseButton.setTitleColor(.black, for: .normal)  // 텍스트 색상 검정
        increaseButton.layer.cornerRadius = 16              // 원형 모양을 위한 설정
        increaseButton.backgroundColor = .side              // 배경색 설정
        setupButtonShadow(for: increaseButton)              // 그림자 효과 추가
        // 버튼 제약조건: 중앙 정렬, 수량 레이블 오른쪽 18pt, 너비 32pt
        increaseButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(quantityLabel.snp.trailing).offset(18)
            make.width.equalTo(32)
        }
    }
    
    /// 삭제 버튼의 UI를 설정하는 메서드
    /// 휴지통 아이콘을 표시하는 원형 버튼으로 설정하고 그림자 효과를 추가합니다.
    private func setupDeleteButton() {
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)  // 휴지통 아이콘 설정
        deleteButton.tintColor = .personal                                 // 아이콘 색상 설정
        deleteButton.layer.cornerRadius = 16                              // 원형 모양을 위한 설정
        deleteButton.backgroundColor = .side                              // 배경색 설정
        setupButtonShadow(for: deleteButton)                             // 그림자 효과 추가
        // 버튼 제약조건: 중앙 정렬, 증가 버튼 오른쪽 25pt, 32x32 크기
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(increaseButton.snp.trailing).offset(25)
            make.width.height.equalTo(32)
        }
    }
    
    /// 버튼에 그림자 효과를 추가하는 유틸리티 메서드
    /// - Parameter button: 그림자를 추가할 대상 버튼
    private func setupButtonShadow(for button: UIButton) {
        button.layer.shadowColor = UIColor.count.cgColor       // 그림자 색상
        button.layer.shadowOffset = CGSize(width: 0, height: 3) // 그림자 offset (아래로 3pt)
        button.layer.shadowOpacity = 0.2                       // 그림자 투명도 20%
        button.layer.shadowRadius = 1                          // 그림자 블러 반경
    }
}

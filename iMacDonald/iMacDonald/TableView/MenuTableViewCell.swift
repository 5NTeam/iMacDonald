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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 메뉴 이미지 뷰
        
    }

}

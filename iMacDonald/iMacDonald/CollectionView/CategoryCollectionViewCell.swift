//
//  CollectionView.swift
//  iMacDonald
//
//  컬렉션 뷰 담당: 장상경
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    // 컬렉션뷰에 추가할 때 입력할 매개변수(identifier) 정의
    static let identifier: String = "CategoryCollectionViewCell"
    
    private let menuList: [String] = ["All", "Burger", "Chicken", "Vegan", "Side", "Drink"]
    
    // 카테고리의 레이블 값 정의
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Vegan"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.categoryText
        label.backgroundColor = UIColor.category
        label.clipsToBounds = true
        label.layer.cornerRadius = 20
        label.sizeToFit()
        
        return label
    }()
    
    
    /// 컬렉션뷰 셀 아이템 기본 설정
    /// - Parameter frame: 컬렉션뷰 셀 아이템의 frame 값 = .zero 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear
        contentView.addSubview(categoryLabel)
        
        let labelWidthSize = categoryLabel.intrinsicContentSize.width
        let labelHeightSize = categoryLabel.intrinsicContentSize.height
        
        categoryLabel.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView)
            $0.width.equalTo(labelWidthSize + 40)
            $0.height.equalTo(labelHeightSize + 20)
        }
    }
    
    
    /// 필수 생성 지정자
    /// - Parameter coder: 인터페이스 빌더 엔코딩 값
    ///
    /// 인터페이스 빌더로 현재 뷰를 불러올 경우 fatalError를 발생시키지 않고 뷰 인스턴스를 생성
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func editCategoryName(_ indexPath: Int) {
        self.categoryLabel.text = menuList[indexPath]
    }
    
    /// 선택된 카테고리를 강조하는 메소드
    /// - Parameter isSelected: 현재 카테고리가 선택되었는지 확인
    func selectCategory(_ isSelected: Bool) {
        guard isSelected else { return }
        self.categoryLabel.backgroundColor = UIColor.personal
        self.categoryLabel.textColor = .white
        self.categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
}

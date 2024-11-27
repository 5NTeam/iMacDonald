//
//  CollectionView.swift
//  iMacDonald
//
//  컬렉션 뷰 담당: 장상경
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    // 컬렉션뷰에 추가할 때 입력할 매개변수(identifier) 정의
    static let identifier: String = "CategoryCollectionViewCell"
    
    // 카테고리 이름
    private let categoryList: [String] = ["All", "Burger", "Chicken", "Vegan", "Side", "Drink"]
    
    // 카테고리의 레이블 값 정의
    private let categoryLabel: UILabel = {
        let label = UILabel()
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
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    /// 필수 생성 지정자
    /// - Parameter coder: 인터페이스 빌더 엔코딩 값
    ///
    /// 인터페이스 빌더로 현재 뷰를 불러올 경우 fatalError를 발생시키지 않고 뷰 인스턴스를 생성
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 컬렉션 뷰의 셀을 재사용하지 못하도록 리셋
    override func prepareForReuse() {
        super.prepareForReuse()
        
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        categoryLabel.textColor = UIColor.categoryText
        categoryLabel.backgroundColor = UIColor.category
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 20
    }
}

// 카테고리 메소드
extension CategoryCollectionViewCell {
    /// 카테고리의 레이블 값을 세팅하는 메소드
    /// - Parameter indexPath: 현재 셀의 index 값
    func categoryLabelConfig(_ indexPath: Int) {
        self.categoryLabel.text = categoryList[indexPath]
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

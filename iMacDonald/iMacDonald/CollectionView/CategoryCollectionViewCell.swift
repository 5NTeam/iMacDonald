//
//  CollectionView.swift
//  iMacDonald
//
//  Created by 장상경
//
//  메뉴 카테고리를 표시하는 컬렉션뷰 셀을 구현한 파일입니다.
//  각 카테고리(All, Burger, Chicken 등)를 둥근 모서리의 버튼 형태로 표시하며,
//  선택된 카테고리는 크기 애니메이션과 함께 강조 표시됩니다.

import UIKit
import SnapKit

/// 카테고리 선택을 위한 커스텀 컬렉션뷰 셀 클래스
/// 각 카테고리 항목을 둥근 모서리의 버튼 형태로 표시합니다.
final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    /// 셀 재사용을 위한 식별자
    /// 컬렉션뷰에 셀을 등록할 때 사용됩니다.
    static let identifier: String = "CategoryCollectionViewCell"
    
    // MARK: - Properties
    /// 표시할 카테고리 목록
    /// 메뉴의 각 카테고리 이름을 담고 있는 배열입니다.
    private let categoryList: [String] = ["All", "Burger", "Chicken", "Vegan", "Side", "Drink"]
    
    /// 카테고리 이름을 표시하는 레이블
    /// 둥근 모서리와 배경색을 가진 버튼 형태로 스타일링됩니다.
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center                                  // 텍스트 중앙 정렬
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)  // 기본 폰트 설정
        label.textColor = UIColor.categoryText                        // 텍스트 색상
        label.backgroundColor = UIColor.category                      // 배경 색상
        label.clipsToBounds = true                                   // 내용이 경계를 벗어나지 않도록 설정
        label.layer.cornerRadius = 20                                // 둥근 모서리 설정 (반지름 20pt)
        label.sizeToFit()                                           // 내용에 맞게 크기 조정
        
        return label
    }()
    
    // MARK: - Initialization
    /// 셀의 기본 초기화 메서드
    /// 레이블의 레이아웃을 설정합니다.
    /// - Parameter frame: 셀의 프레임 (기본값 .zero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear                // 셀 배경 투명 처리
        contentView.addSubview(categoryLabel)
        
        // 레이블이 셀 전체를 채우도록 제약조건 설정
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    /// 스토리보드를 통한 초기화를 지원하는 필수 생성자
    /// - Parameter coder: 스토리보드에서 전달되는 디코더
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 셀이 재사용될 때 호출되는 메서드
    /// 모든 속성을 기본값으로 초기화합니다.
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 레이블 속성을 기본값으로 리셋
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        categoryLabel.textColor = UIColor.categoryText
        categoryLabel.backgroundColor = UIColor.category
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 20
    }
}

// MARK: - Category Methods
extension CategoryCollectionViewCell {
    /// 카테고리 레이블의 텍스트를 설정하는 메서드
    /// - Parameter indexPath: 카테고리 배열의 인덱스
    func categoryLabelConfig(_ indexPath: Int) {
        self.categoryLabel.text = categoryList[indexPath]
    }
    
    /// 선택된 카테고리 셀을 강조 표시하는 메서드
    /// 배경색, 텍스트 색상, 폰트를 변경하고 애니메이션을 적용합니다.
    /// - Parameter isSelected: 셀의 선택 상태
    func selectCategory(_ isSelected: Bool) {
        guard isSelected else { return }
        
        // 선택된 상태의 시각적 스타일 적용
        self.categoryLabel.backgroundColor = UIColor.personal     // 강조 배경색
        self.categoryLabel.textColor = .white                    // 흰색 텍스트
        self.categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)  // 굵은 폰트
        
        // 선택 애니메이션 실행
        scaleEffect()
    }
    
    /// 선택 시 크기 애니메이션을 적용하는 메서드
    /// 셀을 잠시 축소했다가 다시 원래 크기로 복원합니다.
    private func scaleEffect() {
        // 0.5초 동안 부드러운 애니메이션 실행
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            // 크기를 90%로 축소
            self.categoryLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            // 0.05초 후 원래 크기로 복원
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.categoryLabel.transform = .identity
            }
        }
    }
}

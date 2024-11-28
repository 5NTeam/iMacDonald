//
//  CategoryView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit
import SnapKit

/// 카테고리 변경 델리게이트 프로토콜
protocol CategoryViewDelegate: AnyObject {
    func categoryDidChange(_ category: Categorys)
}

/// 커스텀 카테고리뷰
final class CategoryView: UIView {
    
    private var collectionView: UICollectionView
    private let titleLogo = UILabel()
    private var state: Categorys = .all
    private var currentState: Int = 0
    
    weak var delegate: CategoryViewDelegate?
    
    /// 카테고리뷰 생성 이니셜라이저
    /// - Parameter frame: 카테고리뷰가 가지는 frame = .zero
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        setupUIConfig()
    }
    
    /// 필수 생성자
    /// - Parameter coder: 인터페이스빌더의 엔코딩 값
    ///
    /// 인터페이스빌더를 통해 뷰를 호출할 경우 인스턴스 생성
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
        
        setupUIConfig()
    }
    
    /// 컬렉션 뷰와 로고의 세팅 메소드
    private func setupUIConfig() {
        setupLogo()
        setupCollectionView()
    }
}

// 카테고리뷰 클래스의 뷰 요소 세팅 메소드
private extension CategoryView {
    /// 로고의 세팅 메소드
    func setupLogo() {
        titleLogo.text = "iMacDonald"
        titleLogo.font = UIFont.systemFont(ofSize: 30, weight: .black)
        titleLogo.backgroundColor = UIColor.clear
        titleLogo.textAlignment = .center
        titleLogo.textColor = UIColor.personal
        self.addSubview(titleLogo)
        
        titleLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    /// 컬렉션뷰의 세팅 메소드
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLogo.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
}

// 컬렉션뷰의 델리게이트 및 데이터소스 구현부
extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    /// 컬렉션뷰의 셀 아이템 수량을 설정
    /// - Parameters:
    ///   - collectionView: 컬렉션뷰 인스턴스
    ///   - section: 셀 구역을 나누는 값 = 없음
    /// - Returns: 셀의 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categorys.allCases.count  // CollectionViewTestMenuCategory를 Categorys로 변경
    }
    
    /// 컬렉션뷰에 셀을 등록하는 메소드
    /// - Parameters:
    ///   - collectionView: 컬렉션뷰 인스턴스
    ///   - indexPath: 컬렉션뷰의 IndexPath
    /// - Returns: 컬렉션뷰 셀(CategoryCollectionViewCell)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        // 셀의 레이블을 설정하는 메소드
        cell.categoryLabelConfig(indexPath.item)
        
        // 셀의 선택을 감지하고 강조하는 메소드
        let isSelected: Bool = indexPath.item == currentState
        cell.selectCategory(isSelected)
        
        // 카테고리를 선택하면 자동으로 스크롤 되도록 설정
        if isSelected {
            let targetOffsetX: CGFloat
            
            if cell.frame.origin.x < collectionView.contentSize.width - collectionView.bounds.width {
                targetOffsetX = indexPath.item != 0 ? cell.frame.origin.x - 70 : cell.frame.origin.x
            } else {
                targetOffsetX = collectionView.contentSize.width - collectionView.bounds.width
            }
            
            // 애니메이션으로 스크롤 이동
            collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        }
        
        return cell
    }
    
    /// 셀이 선택되었을 때를 감지하는 메소드
    /// - Parameters:
    ///   - collectionView: 컬렉션뷰 인스턴스
    ///   - indexPath: 컬렉션뷰의 IndexPath
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 선택된 셀이 몇 번째 셀인지에 따라 카테고리 변경
        switch indexPath.item {
        case 0: self.state = .all
        case 1: self.state = .burger
        case 2: self.state = .chicken
        case 3: self.state = .vegan
        case 4: self.state = .side
        case 5: self.state = .drink
        default: break
        }
        
        // 현재 카테고리에 따라 state값 변경
        switch self.state {
        case .all: self.currentState = 0
        case .burger: self.currentState = 1
        case .chicken: self.currentState = 2
        case .vegan: self.currentState = 3
        case .side: self.currentState = 4
        case .drink: self.currentState = 5
        }
        
        // 컬렉션뷰 reload
        collectionView.reloadData()
        
        delegate?.categoryDidChange(self.state)
    }
}

//
//  CategoryView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit
import SnapKit


/// 커스텀 카테고리뷰
final class CategoryView: UIView {
    
    private var collectionView: UICollectionView
    private let titleLogo = UILabel()
    private var state: CollectionViewTestMenuCategory = .all
    private var currentState: Int = 0
    
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
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}

// 컬렉션뷰의 델리게이트 및 데이터소스 구현부
extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionViewTestMenuCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryLabelConfig(indexPath.item)
        
        let isSelected: Bool = indexPath.item == currentState
        cell.selectCategory(isSelected)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
        case 0: self.state = .all
        case 1: self.state = .burger
        case 2: self.state = .chicken
        case 3: self.state = .vegan
        case 4: self.state = .side
        case 5: self.state = .drink
        default: break
        }
        
        switch self.state {
        case .all: self.currentState = 0
        case .burger: self.currentState = 1
        case .chicken: self.currentState = 2
        case .vegan: self.currentState = 3
        case .side: self.currentState = 4
        case .drink: self.currentState = 5
        }
                
        collectionView.reloadData()
    }
}

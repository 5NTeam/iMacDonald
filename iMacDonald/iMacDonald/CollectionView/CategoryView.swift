//
//  CategoryView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit
import SnapKit

class CategoryView: UIView {
    
    private var collectionView: UICollectionView
    private let titleLogo = UILabel()
    private var state: CollectionViewTestMenuCategory = .all
    private var currentState: Int = 0
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 50)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)

        setupUIConfig()
    }
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 50)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
        
        setupUIConfig()
    }
    
    private func setupUIConfig() {
        setupLogo()
        setupCollectionView()
    }
}

extension CategoryView {
    private func setupLogo() {
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
    
    private func setupCollectionView() {
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
        case 0:
            self.state = .all
        case 1:
            self.state = .burger
        case 2:
            self.state = .chicken
        case 3:
            self.state = .vegan
        case 4:
            self.state = .side
        case 5:
            self.state = .drink
        default:
            break
        }
        
        switch self.state {
        case .all:
            self.currentState = 0
        case .burger:
            self.currentState = 1
        case .chicken:
            self.currentState = 2
        case .vegan:
            self.currentState = 3
        case .side:
            self.currentState = 4
        case .drink:
            self.currentState = 5
        }
                
        collectionView.reloadData()
    }
}

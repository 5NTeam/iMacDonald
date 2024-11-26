//
//  CollectionViewTestController.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit

enum CollectionViewTestMenuCategory: String {
    case all
    case burger
    case chicken
    case side
    case drink
    case vegan
}

class CollectionViewTestController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView?
    private var currentCategory: Int = 0
    
    private var state: CollectionViewTestMenuCategory = .all
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .black)
        label.textColor = UIColor.black
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupCollectionView()
    }
    
    private func setupLabel() {
        label.text = self.state.rawValue
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 50)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView?.backgroundColor = UIColor.clear
        
        view.addSubview(collectionView!)
        
        collectionView?.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        let isSelected: Bool = indexPath.item == currentCategory
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
            self.state = .drink
        case 5:
            self.state = .side
        default:
            break
        }
        
        switch self.state {
        case .all:
            self.currentCategory = 0
        case .burger:
            self.currentCategory = 1
        case .chicken:
            self.currentCategory = 2
        case .side:
            self.currentCategory = 3
        case .drink:
            self.currentCategory = 4
        case .vegan:
            self.currentCategory = 5
        }
        
        collectionView.reloadData()
    }
}
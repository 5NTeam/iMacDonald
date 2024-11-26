//
//  CollectionView.swift
//  iMacDonald
//
//  컬렉션 뷰 담당: 장상경
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    let identifier: String = "CategoryCollectionViewCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.categoryText
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}

//
//  CollectionView.swift
//  iMacDonald
//
//  컬렉션 뷰 담당: 장상경
//

import UIKit
import SnapKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "CategoryCollectionViewCell"
    
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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    func
}

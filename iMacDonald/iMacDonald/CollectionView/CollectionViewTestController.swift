//
//  CollectionViewTestController.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit
import SnapKit

// 테스트용 ViewController
final class CollectionViewTestController: UIViewController {

    private let category = CategoryView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupCategory()
    }
    
    private func setupCategory() {
        view.addSubview(category)
        
        category.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
}

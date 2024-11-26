//
//  ViewController.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    private let checkoutView = CheckoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCheckoutView()
    }
    
    private func setupCheckoutView() {
        view.addSubview(checkoutView)
        
        checkoutView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            // 높이는 콘텐츠에 따라 자동으로 조정됩니다
        }
        
        // 예시: 총 수량과 금액 업데이트
        checkoutView.updateTotalQuantity(3)
        checkoutView.updateTotalAmount(12500)
    }
}


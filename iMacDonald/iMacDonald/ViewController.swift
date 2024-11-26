//
//  ViewController.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController {
    // MARK: - Properties
    private let checkoutView = CheckoutView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 테스트를 위한 예시 데이터
        updateTotalQuantity(3)
        updateTotalAmount(12500)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(checkoutView)
        
        checkoutView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    // MARK: - Public Methods
    func updateTotalQuantity(_ quantity: Int) {
        checkoutView.updateTotalQuantity(quantity)
    }
    
    func updateTotalAmount(_ amount: Int) {
        checkoutView.updateTotalAmount(amount)
    }
}

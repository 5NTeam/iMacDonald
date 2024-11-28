////
////  CardViewController.swift
////  iMacDonald
////
////  Created by Hwangseokbeom on 11/26/24.
////
//
//import UIKit
//
//class CardViewController: UIViewController, CardViewDelegate {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//    
//    private func setupUI() {
//
//        view.backgroundColor = .black
//        
//        // CardView 생성 및 데이터 전달
//        let cardView = CardView(name: "치즈버거", price: 4000, image: UIImage(named: "cheeseburger"))
//        view.addSubview(cardView)
//        cardView.delegate = self
//        // CardView 제약 조건 설정
//        cardView.snp.makeConstraints { make in
//            make.center.equalToSuperview() // 화면 중앙에 배치
//            make.width.equalToSuperview().multipliedBy(0.8) // 화면 너비의 80%
//            make.height.equalTo(cardView.snp.width).multipliedBy(1.2) // 카드뷰의 높이를 너비의 1.2배로 설정
//        }
//    }
//    
//    func cardViewButtonTapped(_ data: MenuData) {
//        
//    }
//}
//

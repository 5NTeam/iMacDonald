//
//  MainView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//


import UIKit
import SnapKit

final class MainView: UIViewController {
    // MARK: - UI Components
    private let categoryView = CategoryView()
    
    private var cartView = SpecialTableView()
    
    private let buttonView = ButtonView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let menuGridStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Properties
    private var menuList: [MenuData] = MenuData.menuList
    private var selectedCategory: Categorys = .all {
        didSet {
            updateMenuItems()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateMenuItems()
    }
}

// MARK: - UI Setup
private extension MainView {
    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCategory()
        setupScrollView()
        setupButtonView()
        setupCartView()
    }
    
    func setupButtonView() {
        buttonView.delegate = self
        buttonView.isUserInteractionEnabled = true
        buttonView.isHidden = true
        view.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(300)
            make.height.equalTo(145)
        }
    }
    
    func setupCartView() {
        cartView.delegate = self
        cartView.sendDelegate = self
        view.addSubview(cartView)
        
        cartView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(270)
        }
    }
    
    func setupCategory() {
        view.addSubview(categoryView)
        categoryView.delegate = self
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(menuGridStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(13) // 13포인트의 여백 추가
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        menuGridStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.width.equalTo(scrollView).offset(-32)
        }
    }
}

// MARK: - Menu Items Setup
private extension MainView {
    func updateMenuItems() {
        menuGridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let filteredMenus = selectedCategory == .all ?
        menuList.sorted(by: { $0.category?.rawValue ?? "" < $1.category?.rawValue ?? "" }) : menuList.sorted(by: >).filter { $0.category == selectedCategory }
        let rows = stride(from: 0, to: filteredMenus.count, by: 2)
        
        rows.forEach { rowIndex in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 16
            
            let firstCard = createCardView(with: filteredMenus[rowIndex])
            rowStackView.addArrangedSubview(firstCard)
            
            if rowIndex + 1 < filteredMenus.count {
                let secondCard = createCardView(with: filteredMenus[rowIndex + 1])
                rowStackView.addArrangedSubview(secondCard)
            } else {
                let emptyView = UIView()
                rowStackView.addArrangedSubview(emptyView)
            }
            
            menuGridStackView.addArrangedSubview(rowStackView)
        }
    }
    
    func createCardView(with menuItem: MenuData) -> UIView {
        let cardView = CardView(name: menuItem.name,
                              price: menuItem.price,
                              image: menuItem.image)
        
        cardView.delegate = self
        
        cardView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        return cardView
    }
}

// MARK: - CategoryView Delegate
extension MainView: CategoryViewDelegate {
    func categoryDidChange(_ category: Categorys) {
        selectedCategory = category
    }
}

extension MainView: CardViewDelegate {
    func cardViewButtonTapped(_ data: MenuData) {
        UIView.animate(withDuration: 0.3) {
            self.cartView.insertCart(data)
            self.view.layoutIfNeeded()
        }
    }
}

extension MainView: ButtonViewDelegate {
    func didTapCancelButton() {
        guard self.cartView.checkCartCount() > 0 else {
            return
        }
        AlertManager.showAlert(from: self, title: "주문 취소", message: "장바구니의 항목을 모두 삭제하시겠습니까?") {
            self.cartView.clearCart()
        }
    }
    
    func didTapPaymentButton() {
        guard self.cartView.checkCartCount() > 0 else {
            return
        }
        AlertManager.showAlert(from: self, title: "결제하기", message: "모든 상품을 구매하시겠습니까?") {
            self.cartView.clearCart()
            AlertManager.succesePayment(from: self, title: "결제 성공", message: "상품의 결제가 완료되었습니다!!")
        }
    }
}

extension MainView: SpecialTableViewDelegate {
    func updateInfoLabel() {
        UIView.animate(withDuration: 0.2) {
            guard self.cartView.checkCartCount() > 0 else {
                return
            }
            
            self.buttonView.updateTotalQuantity(self.cartView.checkShoppingBasket())
            self.buttonView.updateTotalAmount(self.cartView.calcurateTotalPrice())
        }
    }
    
    func sendTableViewCellData() {
        UIView.animate(withDuration: 0.2) {
            guard self.cartView.checkCartCount() > 0 else {
                self.buttonView.frame.origin.y += 300
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.buttonView.isHidden = true
                }
                self.view.layoutIfNeeded()
                return
            }
            
            self.buttonView.snp.makeConstraints {
                $0.bottom.equalToSuperview()
            }
            self.buttonView.isHidden = false
            self.view.layoutIfNeeded()
        }
    }
}

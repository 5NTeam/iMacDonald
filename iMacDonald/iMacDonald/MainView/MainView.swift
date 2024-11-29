//
//  MainView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//
//  맥도날드 앱의 메인 화면을 구현한 뷰 컨트롤러입니다.
//  카테고리 선택, 메뉴 그리드 표시, 장바구니, 결제 기능을 총괄하는 메인 화면입니다.
//  SnapKit을 사용하여 오토레이아웃을 구현했습니다.

import UIKit
import SnapKit

/// 앱의 메인 화면을 담당하는 뷰 컨트롤러
/// 메뉴 카테고리, 메뉴 그리드, 장바구니, 결제 버튼 등을 포함합니다.
final class MainView: UIViewController {
    // MARK: - UI Components
    /// 상단의 메뉴 카테고리 선택 뷰
    private let categoryView = CategoryView()
    
    /// 장바구니 기능을 담당하는 테이블뷰
    private var cartView = SpecialTableView()
    
    /// 하단의 결제 및 취소 버튼을 포함하는 뷰
    private let buttonView = ButtonView()
    
    /// 메뉴 그리드를 스크롤 가능하게 표시하는 스크롤뷰
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false  // 수직 스크롤바 숨김
        return scrollView
    }()
    
    /// 메뉴 카드들을 격자 형태로 배치하는 스택뷰
    private let menuGridStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical        // 수직 방향 스택뷰
        stackView.spacing = 16            // 아이템 간 간격 16pt
        return stackView
    }()
    
    // MARK: - Properties
    /// 표시할 전체 메뉴 목록 데이터
    private var menuList: [MenuData] = MenuData.menuList
    
    /// 현재 선택된 메뉴 카테고리
    /// 카테고리가 변경되면 자동으로 메뉴 아이템을 업데이트합니다.
    private var selectedCategory: Categorys = .all {
        didSet {
            updateMenuItems()
        }
    }
    
    // MARK: - Lifecycle Methods
    /// 뷰 컨트롤러가 메모리에 로드된 후 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()           // UI 초기 설정
        updateMenuItems()   // 메뉴 아이템 초기 구성
    }
}

// MARK: - UI Setup
private extension MainView {
    /// 메인 화면의 전체 UI를 설정하는 메서드
    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCategory()    // 카테고리 뷰 설정
        setupScrollView()  // 스크롤뷰 설정
        setupButtonView()  // 버튼 뷰 설정
        setupCartView()    // 장바구니 뷰 설정
    }
    
    /// 하단 결제/취소 버튼 뷰를 설정하는 메서드
    func setupButtonView() {
        buttonView.delegate = self
        buttonView.isUserInteractionEnabled = true
        buttonView.isHidden = true  // 초기에는 숨김 상태
        view.addSubview(buttonView)
        
        // 버튼 뷰 제약조건 설정: 화면 하단에 고정, 높이 145pt
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(300)
            make.height.equalTo(145)
        }
    }
    
    /// 장바구니 뷰를 설정하는 메서드
    func setupCartView() {
        cartView.delegate = self
        cartView.sendDelegate = self
        view.addSubview(cartView)
        
        // 장바구니 뷰 제약조건 설정: 버튼 뷰 위에 위치, 높이 270pt
        cartView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonView.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(270)
        }
    }
    
    /// 카테고리 선택 뷰를 설정하는 메서드
    func setupCategory() {
        view.addSubview(categoryView)
        categoryView.delegate = self
        
        // 카테고리 뷰 제약조건 설정: 상단 안전영역 아래, 높이 100pt
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    /// 메뉴 그리드를 포함하는 스크롤뷰를 설정하는 메서드
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(menuGridStackView)
        
        // 스크롤뷰 제약조건 설정
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        // 메뉴 그리드 스택뷰 제약조건 설정: 좌우 16pt 여백
        menuGridStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.width.equalTo(scrollView).offset(-32)
        }
    }
}

// MARK: - Menu Items Setup
private extension MainView {
    /// 메뉴 아이템들을 업데이트하는 메서드
    /// 선택된 카테고리에 따라 메뉴를 필터링하고 그리드로 표시합니다.
    func updateMenuItems() {
        // 기존 메뉴 아이템들 제거
        menuGridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 카테고리에 따라 메뉴 필터링
        let filteredMenus = selectedCategory == .all ?
            menuList.sorted(by: { $0.category?.rawValue ?? "" < $1.category?.rawValue ?? "" }) :
            menuList.sorted(by: >).filter { $0.category == selectedCategory }
        
        // 2열 그리드로 메뉴 카드 배치
        let rows = stride(from: 0, to: filteredMenus.count, by: 2)
        
        rows.forEach { rowIndex in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 16
            
            // 첫 번째 카드 추가
            let firstCard = createCardView(with: filteredMenus[rowIndex])
            rowStackView.addArrangedSubview(firstCard)
            
            // 두 번째 카드가 있으면 추가, 없으면 빈 뷰 추가
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
    
    /// 메뉴 아이템의 카드 뷰를 생성하는 메서드
    /// - Parameter menuItem: 표시할 메뉴 데이터
    /// - Returns: 구성된 카드 뷰
    func createCardView(with menuItem: MenuData) -> UIView {
        let cardView = CardView(name: menuItem.name,
                              price: menuItem.price,
                              image: menuItem.image)
        
        cardView.delegate = self
        
        // 카드 뷰 높이 200pt로 설정
        cardView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        return cardView
    }
}

// MARK: - CategoryView Delegate
extension MainView: CategoryViewDelegate {
    func showEasterEggs() {
        AlertManager.showEasterEggsAlert(from: self, title: "5N조를 소개합니다", message: "5명의 MBTI는 모두 N을 포함하고 있다!!\n\n\n\n\n\n\n\n\n\n")
    }
    
    /// 카테고리 선택이 변경되었을 때 호출되는 메서드
    func categoryDidChange(_ category: Categorys) {
        selectedCategory = category
    }
}

// MARK: - CardView Delegate
extension MainView: CardViewDelegate {
    /// 메뉴 카드의 버튼이 탭되었을 때 호출되는 메서드
    /// 선택된 메뉴를 장바구니에 추가합니다.
    func cardViewButtonTapped(_ data: MenuData) {
        UIView.animate(withDuration: 0.3) {
            self.cartView.insertCart(data)
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - ButtonView Delegate
extension MainView: ButtonViewDelegate {
    /// 주문 취소 버튼이 탭되었을 때 호출되는 메서드
    func didTapCancelButton() {
        guard self.cartView.checkCartCount() > 0 else {
            return
        }
        AlertManager.showAlert(from: self, title: "주문 취소", message: "장바구니의 항목을 모두 삭제하시겠습니까?") {
            self.cartView.clearCart()
        }
    }
    
    /// 결제하기 버튼이 탭되었을 때 호출되는 메서드
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

// MARK: - SpecialTableView Delegate
extension MainView: SpecialTableViewDelegate {
    /// 장바구니의 정보 레이블을 업데이트하는 메서드
    /// 총 수량과 금액을 업데이트합니다.
    func updateInfoLabel() {
        UIView.animate(withDuration: 0.2) {
            guard self.cartView.checkCartCount() > 0 else {
                return
            }
            
            self.buttonView.updateTotalQuantity(self.cartView.checkShoppingBasket())
            self.buttonView.updateTotalAmount(self.cartView.calcurateTotalPrice())
        }
    }
    
    /// 장바구니 데이터가 변경되었을 때 호출되는 메서드
    /// 장바구니가 비어있으면 버튼 뷰를 숨깁니다.
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

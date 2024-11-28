//
//  TestTabelView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/28/24.
//
//  맥도날드 메뉴 장바구니를 구현한 특별한 테이블뷰 클래스입니다.
//  장바구니의 메뉴 추가, 삭제, 수량 조절 등의 핵심 기능을 담당합니다.

import UIKit
import SnapKit

/// 테이블뷰의 데이터 변경사항을 상위 뷰에 전달하기 위한 델리게이트 프로토콜
protocol SpecialTableViewDelegate: AnyObject {
    /// 테이블뷰 셀 데이터가 변경되었을 때 호출되는 메서드
    func sendTableViewCellData()
    
    /// 정보 레이블 업데이트가 필요할 때 호출되는 메서드 (가격, 수량 등)
    func updateInfoLabel()
}

/// UIView와 UITableView 프로토콜들을 결합한 타입 별칭
/// 테이블뷰의 기본 기능(delegate, dataSource)을 UIView와 결합
typealias SpecialTable = UIView & UITableViewDelegate & UITableViewDataSource

/// 장바구니 기능을 구현한 커스텀 테이블뷰 클래스
final class SpecialTableView: SpecialTable {
    
    // MARK: - Properties
    /// 실제 테이블뷰 인스턴스
    private let tableView = UITableView()
    
    /// 장바구니에 담긴 메뉴 데이터 배열
    private var cart: [MenuData] = []
    
    /// 수량 증가 버튼 길게 누를 때 사용되는 타이머
    private var increaseTimer: Timer?
    
    /// 카드뷰 관련 동작을 위한 델리게이트
    weak var delegate: CardViewDelegate?
    
    /// 테이블뷰 데이터 변경사항을 전달하기 위한 델리게이트
    weak var sendDelegate: SpecialTableViewDelegate?
    
    // MARK: - View Lifecycle Methods
    /// 터치 이벤트 처리를 위한 메서드
    /// 테이블뷰 영역 외의 터치는 무시하도록 구현
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !tableView.frame.contains(point) else {
            return super.hitTest(point, with: event)
        }
        return nil
    }
    
    /// 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 반투명한 배경색 설정
        tableView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
        
        setupTableView()
        tableView.isHidden = false
        
        // 스크롤 바 숨김 처리
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods
private extension SpecialTableView {
    /// 테이블뷰 초기 설정 메서드
    func setupTableView() {
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 커스텀 셀 등록 및 기본 높이 설정
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = 90
        
        // 초기 제약조건 설정 (처음에는 높이 0으로 시작)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0)
        }
    }
    
    /// 수량 감소 버튼 동작 처리
    /// - Parameter sender: 터치된 감소 버튼
    @objc func decreaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < cart.count else { return }
        
        cart[index].quantity -= 1
        
        // 수량이 0이 되면 해당 메뉴 삭제
        if cart[index].quantity == 0 {
            cart.remove(at: index)
            tableView.reloadData()
        } else {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        // 델리게이트에 변경사항 알림
        self.sendDelegate?.sendTableViewCellData()
        self.sendDelegate?.updateInfoLabel()
        
        updateTableViewHeight()
    }
    
    /// 수량 증가 버튼 동작 처리
    /// - Parameter sender: 터치된 증가 버튼
    @objc func increaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < cart.count else { return }
        
        // 최대 수량 50개 제한
        if cart[index].quantity < 50 {
            cart[index].quantity += 1
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            print("수량은 최대 50까지 가능합니다.")
        }
        self.sendDelegate?.updateInfoLabel()
    }
    
    /// 메뉴 삭제 버튼 동작 처리
    /// - Parameter sender: 터치된 삭제 버튼
    @objc func deleteItem(sender: UIButton) {
        let row = sender.tag
        guard row < cart.count else { return }
        
        cart.remove(at: row)
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
        
        updateTableViewHeight()
        
        self.sendDelegate?.sendTableViewCellData()
        self.sendDelegate?.updateInfoLabel()
        
        tableView.reloadData()
    }
    
    /// 수량 증가 버튼 길게 누르기 제스처 처리
    /// - Parameter gesture: 감지된 길게 누르기 제스처
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let button = gesture.view as? UIButton, button.tag < cart.count else { return }
        
        switch gesture.state {
        case .began:
            // 0.1초 간격으로 수량 증가
            increaseTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.increaseQuantity(sender: button)
            }
        case .ended, .cancelled:
            increaseTimer?.invalidate()
            increaseTimer = nil
        default:
            break
        }
    }
    
    /// 테이블뷰 높이 업데이트 메서드
    /// 장바구니에 담긴 메뉴 수에 따라 높이 조절 (최대 3개 높이까지만 표시)
    func updateTableViewHeight() {
        let rowCount = cart.count
        let maxRowsToShow = 3
        
        let height = min(rowCount, maxRowsToShow) * 90
        tableView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        tableView.layoutIfNeeded()
    }
    
    /// 버튼에 그림자 효과를 추가하는 메서드
    /// - Parameter button: 그림자를 추가할 버튼
    func addShadowToButton(_ button: UIButton) {
        button.layer.shadowColor = UIColor.categoryText.cgColor
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 1
        button.layer.masksToBounds = false
    }
}

// MARK: - Public Methods
extension SpecialTableView {
    /// 장바구니의 총 메뉴 수량을 계산하는 메서드
    /// - Returns: 모든 메뉴의 수량 합계
    func checkShoppingBasket() -> Int {
        let result = self.cart.reduce(0, { $0 + $1.quantity } )
        return result
    }
    
    /// 장바구니의 총 금액을 계산하는 메서드
    /// - Returns: 모든 메뉴의 (가격 × 수량) 합계
    func calcurateTotalPrice() -> Int {
        var result: Int = 0
        
        for menu in self.cart {
            let menuPrice = menu.price * menu.quantity
            result += menuPrice
        }
        
        return result
    }
    
    /// 장바구니에 담긴 메뉴 종류 수를 반환하는 메서드
    /// - Returns: 장바구니의 메뉴 종류 수
    func checkCartCount() -> Int {
        self.cart.count
    }
    
    /// 장바구니를 비우는 메서드
    /// 애니메이션과 함께 모든 메뉴 제거
    func clearCart() {
        UIView.animate(withDuration: 0.1) {
            self.cart.removeAll()
            self.sendDelegate?.sendTableViewCellData()
            self.sendDelegate?.updateInfoLabel()
            self.updateTableViewHeight()
            self.tableView.layoutIfNeeded()
        }
    }
    
    /// 장바구니에 새로운 메뉴를 추가하는 메서드
    /// - Parameter menu: 추가할 메뉴 데이터
    func insertCart(_ menu: MenuData) {
        // 동일한 메뉴가 있으면 수량만 증가
        if let index = cart.firstIndex(where: { $0.name == menu.name }) {
            cart[index].quantity += menu.quantity
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            cart.append(menu)
            tableView.reloadData()
        }
        
        if self.cart.count > 0 {
            tableView.isHidden = false
        }
        
        updateTableViewHeight()
        
        self.sendDelegate?.sendTableViewCellData()
        self.sendDelegate?.updateInfoLabel()
        
        // 새로운 메뉴 추가 시 해당 위치로 스크롤
        if cart.count > 0 {
            tableView.layoutIfNeeded()
            let lastIndex = IndexPath(row: cart.count - 1, section: 0)
            tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        }
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SpecialTableView {
    /// 테이블뷰의 행 수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    /// 테이블뷰 셀을 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        
        configureCellButtons(for: cell, at: indexPath)
        cell.selectionStyle = .none
        
        // 3개 이상의 메뉴가 있을 때만 스크롤 가능하도록 설정
        self.tableView.isScrollEnabled = self.cart.count > 3
        
        // 수량 증가 버튼에 길게 누르기 제스처 추가
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        cell.increaseButton.addGestureRecognizer(longPress)
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    /// 테이블뷰 셀의 버튼들을 설정하는 메서드
    /// - Parameters:
    ///   - cell: 설정할 셀
    ///   - indexPath: 셀의 위치
    func configureCellButtons(for cell: MenuTableViewCell, at indexPath: IndexPath) {
        let item = cart[indexPath.row]
        
        // 셀 데이터 설정
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price)원"
        cell.quantityLabel.text = "\(item.quantity)"
        cell.menuImageView.image = item.image
        
        // 버튼 태그 설정
        cell.decreaseButton.tag = indexPath.row
        cell.increaseButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        
        // 버튼 그림자 효과 추가
        addShadowToButton(cell.decreaseButton)
        addShadowToButton(cell.increaseButton)
        addShadowToButton(cell.deleteButton)
        
        // 버튼 액션 설정
        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
}

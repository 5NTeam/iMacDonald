//
//  TestTabelView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/28/24.
//

import UIKit
import SnapKit

protocol SpecialTableViewDelegate: AnyObject {
    func sendTableViewCellData()
    
    func updateInfoLabel()
}

typealias SpecialTable = UIView & UITableViewDelegate & UITableViewDataSource

final class SpecialTableView: SpecialTable {
    
    private let tableView = UITableView() // 테이블 뷰 선언
    private var cart: [MenuData] = [] // 메뉴 리스트 데이터
    private var increaseTimer: Timer? // 긴 눌림 동작에 사용할 타이머
    
    weak var delegate: CardViewDelegate?
    
    weak var sendDelegate: SpecialTableViewDelegate?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !tableView.frame.contains(point) else {
            return super.hitTest(point, with: event)
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
        
        // 테이블 뷰 설정
        setupTableView()
        
        // 테이블 뷰를 처음에는 숨김
        tableView.isHidden = false
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension SpecialTableView {
    // 테이블 뷰 초기화 메서드
    func setupTableView() {
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 셀 등록 및 레이아웃 설정
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = 90
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0) // 처음에는 높이를 0으로 설정
        }
    }
    
    // 수량 감소
    @objc func decreaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < cart.count else { return }
        
        cart[index].quantity -= 1
        
        // 수량이 0이 되면 해당 항목 삭제
        if cart[index].quantity == 0 {
            cart.remove(at: index)
            self.sendDelegate?.sendTableViewCellData()
            self.sendDelegate?.updateInfoLabel()
            tableView.reloadData()
        } else {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        updateTableViewHeight()
    }
    
    // 수량 증가
    @objc func increaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < cart.count else { return }
        
        // 수량 증가: 최대값 50 제한
        if cart[index].quantity < 50 {
            cart[index].quantity += 1
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            print("수량은 최대 50까지 가능합니다.")
        }
        self.sendDelegate?.updateInfoLabel()
    }
    
    // 아이템 삭제
    @objc func deleteItem(sender: UIButton) {
        let row = sender.tag
        guard row < cart.count else { return }
        
        // 삭제하려는 항목 제거
        cart.remove(at: row)
        
        // 삭제 후 테이블 뷰 업데이트
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
        
        // 테이블 뷰 높이 업데이트
        updateTableViewHeight()
        
        self.sendDelegate?.sendTableViewCellData()
        self.sendDelegate?.updateInfoLabel()
        
        // 삭제 후 테이블을 다시 업데이트 (중요)
        tableView.reloadData()
    }
    
    // 긴 눌림 제스처 처리
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let button = gesture.view as? UIButton, button.tag < cart.count else { return }
        
        switch gesture.state {
        case .began:
            // Long Press 시작 시 타이머 시작
            increaseTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.increaseQuantity(sender: button)
            }
        case .ended, .cancelled:
            // Long Press 종료 시 타이머 멈춤
            increaseTimer?.invalidate()
            increaseTimer = nil
        default:
            break
        }
    }
    
    // 테이블 뷰 높이 갱신 메서드
    func updateTableViewHeight() {
        let rowCount = cart.count
        let maxRowsToShow = 3
        
        // 3개까지만 높이가 증가하도록 설정
        let height = min(rowCount, maxRowsToShow) * 90 // 셀 높이를 90으로 설정했으므로
        tableView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        tableView.layoutIfNeeded()
    }
    
    //그림자 효과 메서드
    func addShadowToButton(_ button: UIButton) {
        button.layer.shadowColor = UIColor.categoryText.cgColor
        button.layer.shadowOpacity = 0.6
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowRadius = 1  // 그림자 반경
        button.layer.masksToBounds = false
    }
}

extension SpecialTableView {
    func calcurateTotalPrice() -> Int {
        var result: Int = 0
        
        for menu in self.cart {
            let menuPrice = menu.price * menu.quantity
            
            result += menuPrice
        }
        
        return result
    }
    
    func checkCartCount() -> Int {
        self.cart.count
    }
    
    func clearCart() {
        UIView.animate(withDuration: 0.1) {
            self.cart.removeAll()
            self.sendDelegate?.sendTableViewCellData()
            self.sendDelegate?.updateInfoLabel()
            self.updateTableViewHeight()
            self.tableView.layoutIfNeeded()
        }
    }
    
    
    /// 테이블뷰에 셀을 추가하는 메소드
    /// - Parameter menu: 추가할 데이터
    func insertCart(_ menu: MenuData) {
        // 만약 같은 이름의 데이터가 있을 경우 해당 데이터의 값을 추가
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
        
        // 품목 추가 시 추가된 품목으로 스크롤 업데이트
        if cart.count > 0 {
            tableView.layoutIfNeeded()
            let lastIndex = IndexPath(row: cart.count - 1, section: 0)
            tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
        }
        
        tableView.reloadData()
    }
    
    // 테이블 뷰 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    // 테이블 뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        configureCellButtons(for: cell, at: indexPath)
        
        cell.selectionStyle = .none
        
        // 3개 이상 품목이 담겨야 스크롤 가능
        if self.cart.count > 3 {
            self.tableView.isScrollEnabled = true
        } else {
            self.tableView.isScrollEnabled = false
        }
        
        // + 버튼에 Long Press 제스처 추가
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        cell.increaseButton.addGestureRecognizer(longPress)
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // 셀 버튼 설정
    func configureCellButtons(for cell: MenuTableViewCell, at indexPath: IndexPath) {
        let item = cart[indexPath.row]
        
        // 데이터 설정
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price)원"
        cell.quantityLabel.text = "\(item.quantity)"
        
        // 이미지 설정 추가
        cell.menuImageView.image = item.image
        
        // 버튼에 태그 및 동작 설정
        cell.decreaseButton.tag = indexPath.row
        cell.increaseButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        
        // 버튼에 그림자 동작 설정
        addShadowToButton(cell.decreaseButton)
        addShadowToButton(cell.increaseButton)
        addShadowToButton(cell.deleteButton)
        
        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
}


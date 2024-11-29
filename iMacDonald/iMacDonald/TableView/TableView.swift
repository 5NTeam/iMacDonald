//
//  TableView.swift
//  iMacDonald
//
//  Created by 김손겸 on 11/25/24.
//
//  장바구니의 메뉴 아이템을 관리하고 표시하는 뷰 컨트롤러입니다.
//  메뉴 추가, 수량 조절, 삭제 기능을 제공하며 테이블뷰를 통해 UI를 구성합니다.

import UIKit
import SnapKit

/// 장바구니의 메뉴 아이템을 관리하는 뷰 컨트롤러
/// UITableView를 사용하여 메뉴 아이템을 표시하고 관리합니다.
class MenuDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardViewDelegate {
    
    // MARK: - Properties
    /// 메뉴 아이템을 표시하는 테이블뷰
    let tableView = UITableView()
    
    /// 장바구니에 담긴 메뉴 아이템 배열
    var cart: [MenuData] = []
    
    /// 수량 증가 버튼 길게 누르기에 사용되는 타이머
    var increaseTimer: Timer?
    
    // MARK: - Lifecycle Methods
    /// 뷰 컨트롤러가 메모리에 로드된 후 호출되는 메서드
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경색 설정
        view.backgroundColor = .count
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        setupTableView()        // 테이블뷰 초기 설정
        tableView.isHidden = true   // 초기에는 테이블뷰 숨김
    }
    
    // MARK: - UI Setup
    /// 테이블뷰의 초기 설정을 수행하는 메서드
    /// 델리게이트, 데이터소스 설정 및 셀 등록을 수행합니다.
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        // 커스텀 셀 등록 및 높이 설정
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = 90
        
        // 테이블뷰 제약조건 설정
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0) // 초기 높이는 0
        }
    }
    
    // MARK: - CardView Delegate
    /// 메뉴 카드의 추가 버튼이 탭되었을 때 호출되는 메서드
    /// - Parameter data: 선택된 메뉴 데이터
    func cardViewButtonTapped(_ data: MenuData) {
        print("선택된 메뉴: \(data.name), 가격: \(data.price)")
        
        // 동일한 메뉴가 있으면 수량만 증가, 없으면 새로 추가
        if let index = cart.firstIndex(where: { $0.name == data.name }) {
            cart[index].quantity += data.quantity
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            cart.append(data)
            tableView.reloadData()
        }
        
        // 테이블뷰 표시 및 높이 업데이트
        tableView.isHidden = false
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
        tableView.layoutIfNeeded()
    }
    
    // MARK: - UITableView DataSource
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
        
        // 메뉴 정보 표시
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price)원"
        cell.quantityLabel.text = "\(item.quantity)"
        
        // 버튼 태그 설정
        cell.decreaseButton.tag = indexPath.row
        cell.increaseButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        
        // 버튼 액션 설정
        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
    
    // MARK: - Button Actions
    /// 수량 감소 버튼 동작 처리
    /// - Parameter sender: 탭된 감소 버튼
    @objc func decreaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < cart.count else { return }
        
        cart[index].quantity -= 1
        
        // 수량이 0이 되면 항목 삭제
        if cart[index].quantity == 0 {
            cart.remove(at: index)
            tableView.reloadData()
        } else {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        updateTableViewHeight()
    }
    
    /// 수량 증가 버튼 동작 처리
    /// - Parameter sender: 탭된 증가 버튼
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
    }
    
    /// 메뉴 삭제 버튼 동작 처리
    /// - Parameter sender: 탭된 삭제 버튼
    @objc func deleteItem(sender: UIButton) {
        let row = sender.tag
        guard row < cart.count else { return }
        
        cart.remove(at: row)
        tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
        updateTableViewHeight()
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
    
    /// 테이블뷰 높이를 업데이트하는 메서드
    /// 최대 3개의 항목만 표시되도록 높이를 제한합니다.
    func updateTableViewHeight() {
        let rowCount = cart.count
        let maxRowsToShow = 3
        
        // 최대 3개 행까지만 높이 설정 (각 행 높이 90pt)
        let height = min(rowCount, maxRowsToShow) * 90
        tableView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        
        tableView.layoutIfNeeded()
    }
}

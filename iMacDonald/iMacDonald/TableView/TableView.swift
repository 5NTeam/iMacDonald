//
//  TableView.swift
//  iMacDonald
//
//  Created by 김손겸 on 11/25/24.
//

import UIKit
import SnapKit

//// 메뉴 데이터 구조체 정의
//enum MenuCategory {
//    case burger
//    case chicken
//    case side
//    case drink
//    case vegan
//}
//
//struct MenuData {
//    var name: String
//    var price: Int
//    var image: UIImage?
//    var category: MenuCategory
//    var quantity: Int = 1 // 기본값: 1
//}

class MenuDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardViewDelegate {
    
    let tableView = UITableView() // 테이블 뷰 선언
    var menuList: [MenuData] = [] // 메뉴 리스트 데이터
    let testCardView = CardView(name: "치즈버거", price: 4000, image: UIImage(named: "cheeseburger"))
    let testCardView1 = CardView(name: "치킨", price: 4500, image: UIImage(named: "chicken"))
    var increaseTimer: Timer? // 긴 눌림 동작에 사용할 타이머
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 화면 설정
        testCardView.delegate = self
        testCardView1.delegate = self
        view.backgroundColor = .count
        tableView.backgroundColor = UIColor.white.withAlphaComponent(0.1)

        
        // 테이블 뷰 설정
        setupTableView()
        
        // 테스트용 CardView 추가
        view.addSubview(testCardView)
        testCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(testCardView.snp.width).multipliedBy(1.2)
        }
        view.addSubview(testCardView1)
        testCardView1.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(testCardView1.snp.width).multipliedBy(1.2)
        }
        
        // 테이블 뷰를 처음에는 숨김
        tableView.isHidden = true
    }
    
    // 테이블 뷰 초기화 메서드
    func setupTableView() {
        view.addSubview(tableView)
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
    
    // CardView 버튼 클릭 이벤트 처리
    func cardViewButtonTapped(_ data: MenuData) {
        print("선택된 메뉴: \(data.name), 가격: \(data.price)")
        
        // 같은 이름의 메뉴가 있는지 확인 후 처리
        if let index = menuList.firstIndex(where: { $0.name == data.name }) {
            menuList[index].quantity += data.quantity
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            menuList.append(data)
            tableView.reloadData()
        }
        
        // 테이블 뷰를 보이도록 설정
        tableView.isHidden = false
        
        // 테이블 뷰 높이를 업데이트
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
        tableView.layoutIfNeeded() // 레이아웃 강제 업데이트
    }
    
    // 테이블 뷰 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    // 테이블 뷰 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        configureCellButtons(for: cell, at: indexPath)
        
        // + 버튼에 Long Press 제스처 추가
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        cell.increaseButton.addGestureRecognizer(longPress)
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // 셀 버튼 설정
    func configureCellButtons(for cell: MenuTableViewCell, at indexPath: IndexPath) {
        let item = menuList[indexPath.row]
        
        // 데이터 설정
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price)원"
        cell.quantityLabel.text = "\(item.quantity)"
        
        // 버튼에 태그 및 동작 설정
        cell.decreaseButton.tag = indexPath.row
        cell.increaseButton.tag = indexPath.row
        cell.deleteButton.tag = indexPath.row
        
        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
    }
    
    // 수량 감소
    @objc func decreaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < menuList.count else { return }
        
        menuList[index].quantity -= 1
        
        // 수량이 0이 되면 해당 항목 삭제
        if menuList[index].quantity == 0 {
            menuList.remove(at: index)
            tableView.reloadData()
        } else {
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        }
        
        updateTableViewHeight()
    }
    
    // 수량 증가
    @objc func increaseQuantity(sender: UIButton) {
        let index = sender.tag
        guard index < menuList.count else { return }
        
        // 수량 증가: 최대값 50 제한
        if menuList[index].quantity < 50 {
            menuList[index].quantity += 1
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        } else {
            print("수량은 최대 50까지 가능합니다.")
        }
    }
    
    // 아이템 삭제
    @objc func deleteItem(sender: UIButton) {
            let row = sender.tag
             guard row < menuList.count else { return }
             
             // 삭제하려는 항목 제거
             menuList.remove(at: row)
             
             // 삭제 후 테이블 뷰 업데이트
            tableView.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
             
             // 테이블 뷰 높이 업데이트
             updateTableViewHeight()
             
             // 삭제 후 테이블을 다시 업데이트 (중요)
             tableView.reloadData()
         }
    
    // 긴 눌림 제스처 처리
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let button = gesture.view as? UIButton, button.tag < menuList.count else { return }
        
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
        tableView.snp.updateConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
        tableView.layoutIfNeeded()
    }
}

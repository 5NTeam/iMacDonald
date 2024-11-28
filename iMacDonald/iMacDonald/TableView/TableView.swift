//
//  TableView.swift
//  iMacDonald
//
//  Created by 김손겸 on 11/25/24.
//
//
//import UIKit
//import SnapKit
//
//////카테고리
////enum MenuCategory {
////    case burger
////    case chicken
////    case side
////    case drink
////    case vegan
////}
////
////// 메뉴 데이터
////struct MenuData {
////    var name: String
////    var price: Int
////    var image: UIImage?
////    var category: MenuCategory
////    var quantity: Int = 1 // 기본값
////}
//
//class MenuDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    let tableView = UITableView()
//    var dummyBurgers: [MenuData] = [
//        MenuData(name: "치즈버거", price: 16000, image: UIImage(named: "cheeseburger"), category: .burger, quantity: 1),
//        MenuData(name: "클래식버거", price: 16000, image: UIImage(named: "classicburger"), category: .burger,quantity: 1),
//        MenuData(name: "더블버거", price: 16000, image: UIImage(named: "doubleburger"), category: .burger,quantity: 1)
//    ]
//    
//    var increaseTimer: Timer?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .lightGray
//        
//        // 테이블 뷰 추가
//        view.addSubview(tableView)
//        tableView.delegate = self
//        tableView.dataSource = self
//        // 재사용 셀로 등록하는 코드
//        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell") // 셀 식별자
//        tableView.rowHeight = 90
//        
//        // 메뉴 항목에 맞춰 높이 자동 수정
//        //let tableViewHeight = CGFloat(dummyBurgers.count) * tableView.rowHeight
//        
//        // SnapKit으로 레이아웃 설정
//        tableView.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview()
//            make.bottom.equalToSuperview() // 하단에 맞춤
//            
//            //동적으로 테이블뷰 높이를 조정하는 코드
//            //make.height.equalTo(tableView.contentSize.height)
//            
//            make.top.equalToSuperview().offset(450) // 테이블 뷰 높이 강제 지정.
//        }
//    }
//    // 테이블 뷰 섹션 내 메뉴 항목 수 만큼 행을 생성
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dummyBurgers.count
//    }
//    
//    // 테이블 뷰 데이터 소스.
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 커스텀 cell 캐스팅
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuTableViewCell else {
//            return UITableViewCell()
//        }
//        
//        configureCellButtons(for: cell, at: indexPath)
//        
//        // + 버튼에 Long Press 제스처 추가
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
//        cell.increaseButton.addGestureRecognizer(longPress)
//        
//        return cell
//    }
//    // 메서드로 정의
//    func configureCellButtons(for cell: MenuTableViewCell, at indexPath: IndexPath) {
//        let item = dummyBurgers[indexPath.row]
//        
//        // 데이터 설정
//        cell.nameLabel.text = item.name
//        cell.priceLabel.text = "\(item.price)원"
//        cell.quantityLabel.text = "\(item.quantity)"
//        
//        cell.decreaseButton.tag = indexPath.row
//        cell.increaseButton.tag = indexPath.row
//        cell.deleteButton.tag = indexPath.row
//        
//        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
//        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
//        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
//    }
//    
//    // 수량 감소
//    @objc func decreaseQuantity(sender: UIButton) {
//        let row = sender.tag
//        if dummyBurgers[row].quantity > 1 {
//            dummyBurgers[row].quantity -= 1
//            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? MenuTableViewCell {
//                cell.quantityLabel.text = "\(dummyBurgers[row].quantity)"
//            } else {
//                print("수량 없음")
//            }
//        }
//    }
//    
//    // 수량 증가
//    @objc func increaseQuantity(_ sender: UIButton) {
//        let index = sender.tag
//        guard index < dummyBurgers.count else { return }
//        
//        dummyBurgers[index].quantity += 1
//        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
//    }
//    
//    // 아이템 삭제
//    @objc func deleteItem(sender: UIButton) {
//        let row = sender.tag
//        dummyBurgers.remove(at: row)
//        tableView.reloadData()
//    }
//    // 긴 눌림 제스처
//    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
//        guard let button = gesture.view as? UIButton, button.tag < dummyBurgers.count else { return } // 강제 언래핑 대신 안전하게 tag로 가져옴
//        
//        switch gesture.state {
//        case .began:
//            // Long Press 시작 시 타이머 시작
//            increaseTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
//                self?.increaseQuantity(button)
//            }
//        case .ended, .cancelled:
//            // Long Press 종료 시 타이머 멈춤
//            increaseTimer?.invalidate()
//            increaseTimer = nil
//        default:
//            break
//        }
//    }
//}

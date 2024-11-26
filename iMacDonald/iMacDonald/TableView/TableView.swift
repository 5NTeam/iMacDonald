//
//  TableView.swift
//  iMacDonald
//
//  Created by 김손겸 on 11/25/24.
//

import UIKit
import SnapKit

// 카테고리
enum MenuCategory {
    case burger
    case chicken
    case side
    case drink
    case vegan
}

// 메뉴 데이터
struct MenuData {
    var name: String
    var price: Int
    var image: UIImage?
    var category: MenuCategory
}

class MenuDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    var dummyBurgers: [MenuData] = [
        MenuData(name: "치즈버거", price: 16000, image: UIImage(named: "cheeseburger"), category: .burger),
        MenuData(name: "클래식버거", price: 16000, image: UIImage(named: "classicburger"), category: .burger),
        MenuData(name: "더블버거", price: 16000, image: UIImage(named: "doubleburger"), category: .burger)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        // 테이블 뷰 추가
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        // cell 등록
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = 80
        
        // 메뉴 항목에 맞춰 높이 자동 수정
        //let tableViewHeight = CGFloat(dummyBurgers.count) * tableView.rowHeight
        
        // SnapKit으로 레이아웃 설정
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // 테이블 뷰 갯수마다 자동으로 섹션 생성
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyBurgers.count
    }
    // 테이블 뷰 DataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuTableViewCell else {
            return UITableViewCell()
        }
        // 데이터 설정
        let item = dummyBurgers[indexPath.row]
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price)원"
        cell.quantityLabel.text = "\(item.category)"
        
        // 버튼 액션 설정
        cell.decreaseButton.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        
        return cell
    }
    @objc func decreaseQuantity(sender: UIButton) {
        // 수량 감소 로직
    }
    
    @objc func increaseQuantity(sender: UIButton) {
        // 수량 증가 로직
    }
    
    @objc func deleteItem(sender: UIButton) {
        // 아이템 삭제 로직
    }
}


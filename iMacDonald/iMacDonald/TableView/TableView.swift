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
    var image: String
    var category: MenuCategory
}

class MenuDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let dummyBurgers = [
        MenuData(name: "치즈버거", price: 5000, image: "cheeseburger", category: .burger),
        MenuData(name: "클래식버거", price: 7000, image: "classicburger", category: .burger),
        MenuData(name: "더블버거", price: 8000, image: "doubleburger", category: .burger)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 테이블 뷰 추가
        
    }
}

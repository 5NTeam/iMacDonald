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
        view.backgroundColor = .white
        
        // 테이블 뷰 추가
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.rowHeight = 80
        
        // 메뉴 항목에 맞춰 높이 수정
        let tableViewHeight = CGFloat(dummyBurgers.count) * tableView.rowHeight
        
        // SnapKit으로 레이아웃 설정
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.centerY).offset(40) // 화면 절반보다 좀 더 아래로
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(tableViewHeight) // 안전영역에 맞게
        }
    }
// 테이블 뷰 갯수마다 자동으로 섹션 생성
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyBurgers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        let burger = dummyBurgers[indexPath.row]
        return cell
    }
}

//
//  Untitled.swift
//  iMacDonald
//
//  Created by Hwangseokbeom on 11/26/24.
//

//
//  dd.swift
//  CalApp
//
//  Created by Hwangseokbeom on 11/25/24.
//

import UIKit

//카테고리 enum
enum Categorys: String, Codable {
    case all
    case burger
    case chicken
    case side
    case drink
    case vegan
}

// 메뉴 정보를 저장하는 구조체
struct MenuData {
    let name: String        // 메뉴 이름
    let price: Int       // 메뉴 가격
    let image: UIImage?     // 메뉴 이미지
    let category: Categorys
}

// 메뉴 리스트를 관리하는 구조체
struct MenuRepository {
    static let menuList: [MenuData] = [
        MenuData(name: "아메리카노", price: 4000, image: UIImage(systemName: "cup.and.saucer")),
        MenuData(name: "카페 라떼", price: 4500, image: UIImage(systemName: "mug")),
        MenuData(name: "샌드위치", price: 5500, image: UIImage(systemName: "baguette")),
        MenuData(name: "샐러드", price: 5000, image: UIImage(systemName: "leaf")),
        MenuData(name: "디저트", price: 3000, image: UIImage(systemName: "cake")),
        MenuData(name: "스낵", price: 2000, image: UIImage(systemName: "popcorn"))
    ]
}

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
enum Categorys: String {
    case all
    case burger
    case chicken
    case vegan
    case side
    case drink
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
        MenuData(name: "치즈버거", price: 4000, image: UIImage(systemName: "cheeseburger"), category: .burger),
        MenuData(name: "치킨", price: 4500, image: UIImage(systemName: "chicken"), category: .chicken),
        MenuData(name: "클래식버거", price: 5500, image: UIImage(systemName: "classicburger"), category: .burger),
        MenuData(name: "콜라", price: 5000, image: UIImage(systemName: "cola"), category: .drink),
        MenuData(name: "더블버거", price: 3000, image: UIImage(systemName: "doubleburger"), category: .burger),
        MenuData(name: "햄버거", price: 2000, image: UIImage(systemName: "hamburger"), category: .burger),
        MenuData(name: "아이스티", price: 5000, image: UIImage(systemName: "icetea"), category: .drink),
        MenuData(name: "레몬에이드", price: 3000, image: UIImage(systemName: "lemonade"), category: .side),
        MenuData(name: "너겟", price: 2000, image: UIImage(systemName: "nurget"), category: .side),
        MenuData(name: "어니언링", price: 5000, image: UIImage(systemName: "onionring"), category: .side),
        MenuData(name: "감자튀김", price: 3000, image: UIImage(systemName: "potato"), category: .side),
        MenuData(name: "샐러드버거", price: 2000, image: UIImage(systemName: "saladburger"), category: .burger),
        MenuData(name: "샐러드", price: 5000, image: UIImage(systemName: "salade"), category: .vegan),
        MenuData(name: "스님버거", price: 3000, image: UIImage(systemName: "vegeset"), category: .vegan),
        MenuData(name: "버팔로윙", price: 2000, image: UIImage(systemName: "wing"), category: .side)
    ]
}

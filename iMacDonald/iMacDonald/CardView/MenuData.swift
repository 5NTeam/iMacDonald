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
enum Categorys: String, CaseIterable {
    // CaseIterable 프로토콜 추가
    case all
    case burger
    case chicken
    case vegan
    case side
    case drink
}

// 메뉴 정보를 저장하는 구조체
struct MenuData: Comparable {
    let name: String        // 메뉴 이름
    let price: Int       // 메뉴 가격
    let image: UIImage?     // 메뉴 이미지
    let category: Categorys?
    var quantity: Int = 1
    
    static func < (_ rhs: MenuData, _ lhs: MenuData) -> Bool {
        return rhs.name > lhs.name
    }
    
    static let menuList: [MenuData] = [
        MenuData(name: "치즈버거", price: 4000, image: UIImage(named: "cheeseburger"), category: .burger, quantity: 1),
        MenuData(name: "치킨", price: 4500, image: UIImage(named: "chicken"), category: .chicken, quantity: 1),
        MenuData(name: "클래식버거", price: 5500, image: UIImage(named: "classicburger"), category: .burger, quantity: 1),
        MenuData(name: "콜라", price: 5000, image: UIImage(named: "cola"), category: .drink, quantity: 1),
        MenuData(name: "더블버거", price: 3000, image: UIImage(named: "doubleburger"), category: .burger, quantity: 1),
        MenuData(name: "햄버거", price: 2000, image: UIImage(named: "hamburger"), category: .burger, quantity: 1),
        MenuData(name: "아이스티", price: 5000, image: UIImage(named: "icetea"), category: .drink, quantity: 1),
        MenuData(name: "레몬에이드", price: 3000, image: UIImage(named: "lemonade"), category: .drink, quantity: 1),
        MenuData(name: "너겟", price: 2000, image: UIImage(named: "nurget"), category: .side, quantity: 1),
        MenuData(name: "어니언링", price: 5000, image: UIImage(named: "onionring"), category: .side, quantity: 1),
        MenuData(name: "감자튀김", price: 3000, image: UIImage(named: "potato"), category: .side, quantity: 1),
        MenuData(name: "샐러드버거", price: 2000, image: UIImage(named: "saladburger"), category: .burger, quantity: 1),
        MenuData(name: "샐러드", price: 5000, image: UIImage(named: "salade"), category: .vegan, quantity: 1),
        MenuData(name: "스님버거", price: 3000, image: UIImage(named: "vegeset"), category: .vegan, quantity: 1),
        MenuData(name: "버팔로윙", price: 2000, image: UIImage(named: "wing"), category: .side, quantity: 1)
    ]
}

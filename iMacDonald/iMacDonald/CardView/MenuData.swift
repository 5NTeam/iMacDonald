//
//  MenuData.swift
//  iMacDonald
//
//  Created by Hwangseokbeom on 11/26/24.
//
//  맥도날드 앱의 메뉴 데이터 모델을 정의하는 파일입니다.
//  메뉴의 카테고리와 각 메뉴 항목의 정보를 관리합니다.

import UIKit

/// 메뉴 카테고리를 정의하는 열거형
/// CaseIterable 프로토콜을 채택하여 모든 케이스에 대한 순회가 가능합니다.
enum Categorys: String, CaseIterable {
    /// 전체 메뉴
    case all
    /// 버거 메뉴
    case burger
    /// 치킨 메뉴
    case chicken
    /// 채식 메뉴
    case vegan
    /// 사이드 메뉴
    case side
    /// 음료 메뉴
    case drink
}

/// 개별 메뉴 항목의 정보를 저장하는 구조체
/// Comparable 프로토콜을 채택하여 메뉴 간 정렬이 가능합니다.
struct MenuData: Comparable {
    /// 메뉴의 이름
    let name: String
    
    /// 메뉴의 가격 (원 단위)
    let price: Int
    
    /// 메뉴의 이미지
    /// 옵셔널 타입으로 이미지가 없을 수 있음
    let image: UIImage?
    
    /// 메뉴의 카테고리
    /// 옵셔널 타입으로 카테고리가 없을 수 있음
    let category: Categorys?
    
    /// 주문 수량
    /// 기본값 1로 설정
    var quantity: Int = 1
    
    /// Comparable 프로토콜 요구사항 구현
    /// 메뉴를 이름 기준으로 정렬하기 위한 비교 연산자 구현
    /// - Parameters:
    ///   - rhs: 비교할 첫 번째 메뉴
    ///   - lhs: 비교할 두 번째 메뉴
    /// - Returns: 첫 번째 메뉴 이름이 두 번째 메뉴 이름보다 큰지 여부
    static func < (_ rhs: MenuData, _ lhs: MenuData) -> Bool {
        return rhs.name > lhs.name
    }
    
    /// 앱에서 사용되는 전체 메뉴 리스트
    /// 각 메뉴의 이름, 가격, 이미지, 카테고리 정보를 포함합니다.
    static let menuList: [MenuData] = [
        // 버거 메뉴
        MenuData(name: "치즈버거", price: 4000, image: UIImage(named: "cheeseburger"), category: .burger, quantity: 1),
        MenuData(name: "클래식버거", price: 5500, image: UIImage(named: "classicburger"), category: .burger, quantity: 1),
        MenuData(name: "더블버거", price: 3000, image: UIImage(named: "doubleburger"), category: .burger, quantity: 1),
        MenuData(name: "햄버거", price: 2000, image: UIImage(named: "hamburger"), category: .burger, quantity: 1),
        MenuData(name: "샐러드버거", price: 2000, image: UIImage(named: "saladburger"), category: .burger, quantity: 1),
        
        // 치킨 메뉴
        MenuData(name: "치킨", price: 4500, image: UIImage(named: "chicken"), category: .chicken, quantity: 1),
        
        // 음료 메뉴
        MenuData(name: "콜라", price: 5000, image: UIImage(named: "cola"), category: .drink, quantity: 1),
        MenuData(name: "아이스티", price: 5000, image: UIImage(named: "icetea"), category: .drink, quantity: 1),
        MenuData(name: "레몬에이드", price: 3000, image: UIImage(named: "lemonade"), category: .drink, quantity: 1),
        
        // 사이드 메뉴
        MenuData(name: "너겟", price: 2000, image: UIImage(named: "nurget"), category: .side, quantity: 1),
        MenuData(name: "어니언링", price: 5000, image: UIImage(named: "onionring"), category: .side, quantity: 1),
        MenuData(name: "감자튀김", price: 3000, image: UIImage(named: "potato"), category: .side, quantity: 1),
        MenuData(name: "버팔로윙", price: 2000, image: UIImage(named: "wing"), category: .side, quantity: 1),
        
        // 채식 메뉴
        MenuData(name: "샐러드", price: 5000, image: UIImage(named: "salade"), category: .vegan, quantity: 1),
        MenuData(name: "스님버거", price: 3000, image: UIImage(named: "vegeset"), category: .vegan, quantity: 1)
    ]
}

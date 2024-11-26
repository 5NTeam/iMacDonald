//
//  CollectionViewTestModel.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//

import UIKit

enum CollectionViewTestMenuCategory: String {
    case all
    case burger
    case chicken
    case vegan
    case side
    case drink
}

struct CollectionViewTestModel {
    var name: String
    var price: Int
    var image: UIImage?
    var category: CollectionViewTestMenuCategory
    
    static let menuList: [CollectionViewTestModel] = [
        CollectionViewTestModel(name: "test1", price: 1, category: .burger),
        CollectionViewTestModel(name: "test2", price: 2, category: .burger),
        CollectionViewTestModel(name: "test3", price: 3, category: .burger),
        CollectionViewTestModel(name: "test4", price: 4, category: .chicken),
        CollectionViewTestModel(name: "test5", price: 5, category: .chicken),
        CollectionViewTestModel(name: "test6", price: 6, category: .chicken),
        CollectionViewTestModel(name: "test7", price: 7, category: .vegan),
        CollectionViewTestModel(name: "test8", price: 8, category: .vegan),
        CollectionViewTestModel(name: "test9", price: 9, category: .side),
        CollectionViewTestModel(name: "test10", price: 10, category: .side),
        CollectionViewTestModel(name: "test11", price: 11, category: .side),
        CollectionViewTestModel(name: "test12", price: 12, category: .drink)
    ]
}

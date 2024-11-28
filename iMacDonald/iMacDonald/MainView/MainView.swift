//
//  MainView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//


import UIKit
import SnapKit

final class MainView: UIViewController {
    // MARK: - UI Components
    private let categoryView = CategoryView()
    private let menuDataViewController = MenuDataViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let menuGridStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    // MARK: - Properties
    private var menuList: [MenuData] = MenuData.menuList
    private var selectedCategory: Categorys = .all {
        didSet {
            updateMenuItems()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateMenuItems()
        addMenuDataViewController()
    }
}

// MARK: - UI Setup
private extension MainView {
    func setupUI() {
        view.backgroundColor = .systemBackground
        setupCategory()
        setupScrollView()
    }
    
    func setupCategory() {
        view.addSubview(categoryView)
        categoryView.delegate = self
        
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(menuGridStackView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        menuGridStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.width.equalTo(scrollView).offset(-32)
        }
    }
    
    func addMenuDataViewController() {
        addChild(menuDataViewController)
        view.addSubview(menuDataViewController.view)
        menuDataViewController.didMove(toParent: self)
        
        menuDataViewController.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0) // 초기 높이는 0
        }
    }
}

// MARK: - Menu Items Setup
private extension MainView {
    func updateMenuItems() {
        menuGridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let filteredMenus = selectedCategory == .all ?
            menuList : menuList.filter { $0.category == selectedCategory }
        let rows = stride(from: 0, to: filteredMenus.count, by: 2)
        
        rows.forEach { rowIndex in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 16
            
            let firstCard = createCardView(with: filteredMenus[rowIndex])
            rowStackView.addArrangedSubview(firstCard)
            
            if rowIndex + 1 < filteredMenus.count {
                let secondCard = createCardView(with: filteredMenus[rowIndex + 1])
                rowStackView.addArrangedSubview(secondCard)
            } else {
                let emptyView = UIView()
                rowStackView.addArrangedSubview(emptyView)
            }
            
            menuGridStackView.addArrangedSubview(rowStackView)
        }
    }
    
    func createCardView(with menuItem: MenuData) -> UIView {
        let cardView = CardView(name: menuItem.name,
                              price: menuItem.price,
                              image: menuItem.image)
        cardView.delegate = menuDataViewController
        
        cardView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        return cardView
    }
}

// MARK: - CategoryView Delegate
extension MainView: CategoryViewDelegate {
    func categoryDidChange(_ category: Categorys) {
        selectedCategory = category
    }
}

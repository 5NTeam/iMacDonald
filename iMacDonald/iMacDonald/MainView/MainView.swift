//
//  MainView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//

import UIKit
import SnapKit

// MARK: - Data Models

/// 메뉴 아이템의 데이터 구조를 정의하는 구조체
struct MenuData {
    let name: String      // 메뉴 이름
    let price: Int        // 가격 (센트 단위)
    let image: String     // 이미지 에셋 이름
    let category: Categorys // 메뉴 카테고리
}

/// 메뉴 카테고리를 정의하는 열거형
enum Categorys: String, CaseIterable {
    case burger = "Burger"
    case chicken = "Chicken"
    case side = "Side"
    case drink = "Drink"
    case vegan = "Vegetarian"
}

/// 메뉴 화면을 관리하는 뷰 컨트롤러
class MenuViewController: UIViewController {
    
    // MARK: - UI Components
    
    /// 전체 화면의 스크롤을 담당하는 스크롤 뷰
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false  // 수직 스크롤바 숨김
        return scrollView
    }()
    
    /// 스크롤 뷰 내부의 주요 컨텐츠를 담는 수직 스택 뷰
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical           // 수직 방향 스택
        stackView.spacing = 20               // 컴포넌트 간 간격
        return stackView
    }()
    
    /// 카테고리 버튼들을 가로로 스크롤할 수 있게 하는 스크롤 뷰
    private lazy var categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false  // 수평 스크롤바 숨김
        return scrollView
    }()
    
    /// 카테고리 버튼들을 담는 수평 스택 뷰
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal         // 수평 방향 스택
        stackView.spacing = 15               // 버튼 간 간격
        return stackView
    }()
    
    /// 메뉴 아이템들을 그리드 형태로 표시하는 수직 스택 뷰
    private lazy var menuGridStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical           // 수직 방향 스택
        stackView.spacing = 16               // 행 간 간격
        return stackView
    }()
    
    // MARK: - Properties
    
    /// 표시할 메뉴 데이터 배열
    private var menuList: [MenuData] = [
        MenuData(name: "Classic Cheeseburger", price: 12_99, image: "classic_burger", category: .burger),
        MenuData(name: "Bacon Deluxe", price: 14_99, image: "bacon_deluxe", category: .burger),
        MenuData(name: "Mushroom Swiss", price: 13_99, image: "mushroom_swiss", category: .burger),
        MenuData(name: "Veggie Supreme", price: 11_99, image: "veggie_supreme", category: .vegan),
        MenuData(name: "Spicy Chicken", price: 13_99, image: "spicy_chicken", category: .chicken)
    ]
    
    /// 현재 선택된 카테고리
    private var selectedCategory: Categorys = .burger {
        didSet {
            updateMenuItems()  // 카테고리 변경 시 메뉴 아이템 업데이트
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCategories()
        updateMenuItems()
    }
    
    // MARK: - UI Setup Methods
    
    /// 기본 UI 컴포넌트들을 설정하고 계층 구조를 구성하는 메서드
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // 뷰 계층 구조 설정
        view.addSubview(scrollView)
        scrollView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
        contentStackView.addArrangedSubview(menuGridStackView)
        
        setupConstraints()
    }
    
    /// SnapKit을 사용하여 레이아웃 제약 조건을 설정하는 메서드
    private func setupConstraints() {
        // 메인 스크롤 뷰 제약 조건
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 컨텐츠 스택 뷰 제약 조건
        contentStackView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
            make.width.equalTo(scrollView).offset(-32)  // 좌우 패딩 고려
        }
        
        // 카테고리 스크롤 뷰 높이 설정
        categoryScrollView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        // 카테고리 스택 뷰 제약 조건
        categoryStackView.snp.makeConstraints { make in
            make.edges.height.equalTo(categoryScrollView)
        }
    }
    
    /// 카테고리 버튼들을 생성하고 설정하는 메서드
    private func setupCategories() {
        Categorys.allCases.forEach { category in
            let button = createCategoryButton(with: category)
            categoryStackView.addArrangedSubview(button)
        }
    }
    
    /// 개별 카테고리 버튼을 생성하는 메서드
    /// - Parameter category: 버튼에 표시할 카테고리
    /// - Returns: 구성된 UIButton
    private func createCategoryButton(with category: Categorys) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(category.rawValue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = category == selectedCategory ? .systemRed : .systemGray6
        button.setTitleColor(category == selectedCategory ? .white : .black, for: .normal)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.tag = Categorys.allCases.firstIndex(of: category) ?? 0
        button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
        return button
    }
    
    /// 현재 선택된 카테고리에 따라 메뉴 아이템을 업데이트하는 메서드
    private func updateMenuItems() {
        // 기존 메뉴 아이템 제거
        menuGridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 현재 카테고리에 해당하는 메뉴 필터링
        let filteredMenus = menuList.filter { $0.category == selectedCategory }
        let rows = stride(from: 0, to: filteredMenus.count, by: 2)
        
        // 2열 그리드로 메뉴 아이템 배치
        rows.forEach { rowIndex in
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 16
            
            // 첫 번째 아이템 추가
            let firstItemView = createMenuItemView(with: filteredMenus[rowIndex])
            rowStackView.addArrangedSubview(firstItemView)
            
            // 두 번째 아이템이 있으면 추가, 없으면 빈 뷰 추가
            if rowIndex + 1 < filteredMenus.count {
                let secondItemView = createMenuItemView(with: filteredMenus[rowIndex + 1])
                rowStackView.addArrangedSubview(secondItemView)
            } else {
                let emptyView = UIView()
                rowStackView.addArrangedSubview(emptyView)
            }
            
            menuGridStackView.addArrangedSubview(rowStackView)
        }
    }
    
    /// 개별 메뉴 아이템 뷰를 생성하는 메서드
    /// - Parameter menuItem: 표시할 메뉴 데이터
    /// - Returns: 구성된 메뉴 아이템 뷰
    private func createMenuItemView(with menuItem: MenuData) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 12
        
        // 메뉴 이미지 뷰 설정
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(named: menuItem.image)
        
        // 메뉴 이름 레이블 설정
        let titleLabel = UILabel()
        titleLabel.text = menuItem.name
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        // 가격 레이블 설정
        let priceLabel = UILabel()
        priceLabel.text = "$\(String(format: "%.2f", Double(menuItem.price) / 100))"
        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        priceLabel.textColor = .systemRed
        
        // 추가 버튼 설정
        let addButton = UIButton(type: .system)
        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addButton.tintColor = .systemRed
        
        // 뷰들을 컨테이너에 추가
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(addButton)
        
        // SnapKit을 사용한 제약 조건 설정
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        return containerView
    }
    
    // MARK: - Action Methods
    
    /// 카테고리 버튼 탭 이벤트 처리 메서드
    /// - Parameter sender: 탭된 버튼
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        guard let category = Categorys.allCases[safe: sender.tag] else { return }
        
        // 모든 카테고리 버튼의 스타일 업데이트
        categoryStackView.arrangedSubviews.forEach { view in
            guard let button = view as? UIButton else { return }
            button.backgroundColor = button.tag == sender.tag ? .systemRed : .systemGray6
            button.setTitleColor(button.tag == sender.tag ? .white : .black, for: .normal)
        }
        
        selectedCategory = category
    }
}

// MARK: - Array Extension

/// 배열의 안전한 인덱스 접근을 위한 확장
extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

//
//  MainView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//

//
//import UIKit
//import SnapKit
//
///// 메뉴 화면을 관리하는 뷰 컨트롤러
//class MainView: UIViewController {
//    
//    // MARK: - UI Components
//    private let categoryView = CategoryView()
//    
//    /// 전체 화면의 스크롤을 담당하는 스크롤 뷰
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsVerticalScrollIndicator = false
//        return scrollView
//    }()
//    
//    /// 스크롤 뷰 내부의 주요 컨텐츠를 담는 수직 스택 뷰
//    private lazy var menuGridStackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        return stackView
//    }()
//    
//    // MARK: - Properties
//    
//    /// 표시할 메뉴 데이터 배열
//    private var menuList: [CollectionViewTestModel] = CollectionViewTestModel.menuList
//    
//    /// 현재 선택된 카테고리
//    private var selectedCategory: CollectionViewTestMenuCategory = .all {
//        didSet {
//            updateMenuItems()
//        }
//    }
//    
//    // MARK: - Lifecycle Methods
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//        updateMenuItems()
//    }
//    
//    // MARK: - UI Setup Methods
//    
//    /// 기본 UI 컴포넌트들을 설정하고 계층 구조를 구성하는 메서드
//    private func setupUI() {
//        view.backgroundColor = .systemBackground
//        
//        setupCategoryView()
//        setupScrollView()
//    }
//    
//    /// 카테고리 뷰 설정
//    private func setupCategoryView() {
//        view.addSubview(categoryView)
//        
//        // delegate 설정 추가
//        categoryView.delegate = self
//        
//        categoryView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(100)
//        }
//    }
//    
//    /// 스크롤 뷰 설정
//    private func setupScrollView() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(menuGridStackView)
//        
//        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(categoryView.snp.bottom)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
//        
//        menuGridStackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView).inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
//            make.width.equalTo(scrollView).offset(-32)
//        }
//    }
//    
//    /// 현재 선택된 카테고리에 따라 메뉴 아이템을 업데이트하는 메서드
//    private func updateMenuItems() {
//        // 기존 메뉴 아이템 제거
//        menuGridStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        
//        // 현재 카테고리에 해당하는 메뉴 필터링
//        let filteredMenus = selectedCategory == .all ?
//            menuList : menuList.filter { $0.category == selectedCategory }
//        let rows = stride(from: 0, to: filteredMenus.count, by: 2)
//        
//        // 2열 그리드로 메뉴 아이템 배치
//        rows.forEach { rowIndex in
//            let rowStackView = UIStackView()
//            rowStackView.axis = .horizontal
//            rowStackView.distribution = .fillEqually
//            rowStackView.spacing = 16
//            
//            // 첫 번째 아이템 추가
//            let firstItemView = createMenuItemView(with: filteredMenus[rowIndex])
//            rowStackView.addArrangedSubview(firstItemView)
//            
//            // 두 번째 아이템이 있으면 추가, 없으면 빈 뷰 추가
//            if rowIndex + 1 < filteredMenus.count {
//                let secondItemView = createMenuItemView(with: filteredMenus[rowIndex + 1])
//                rowStackView.addArrangedSubview(secondItemView)
//            } else {
//                let emptyView = UIView()
//                rowStackView.addArrangedSubview(emptyView)
//            }
//            
//            menuGridStackView.addArrangedSubview(rowStackView)
//        }
//    }
//    
//    /// 개별 메뉴 아이템 뷰를 생성하는 메서드
//    /// - Parameter menuItem: 표시할 메뉴 데이터
//    /// - Returns: 구성된 메뉴 아이템 뷰
//    private func createMenuItemView(with menuItem: CollectionViewTestModel) -> UIView {
//        let containerView = UIView()
//        containerView.backgroundColor = .systemGray6
//        containerView.layer.cornerRadius = 12
//        
//        // 메뉴 이미지 뷰 설정
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 8
//        imageView.image = menuItem.image ?? UIImage(systemName: "photo")
//        
//        // 메뉴 이름 레이블 설정
//        let titleLabel = UILabel()
//        titleLabel.text = menuItem.name
//        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
//        titleLabel.textAlignment = .center
//        titleLabel.numberOfLines = 2
//        
//        // 가격 레이블 설정
//        let priceLabel = UILabel()
//        priceLabel.text = "$\(menuItem.price)"
//        priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
//        priceLabel.textColor = UIColor.personal
//        
//        // 추가 버튼 설정
//        let addButton = UIButton(type: .system)
//        addButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
//        addButton.tintColor = UIColor.personal
//        
//        // 뷰들을 컨테이너에 추가
//        containerView.addSubview(imageView)
//        containerView.addSubview(titleLabel)
//        containerView.addSubview(priceLabel)
//        containerView.addSubview(addButton)
//        
//        // SnapKit을 사용한 제약 조건 설정
//        imageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(12)
//            make.centerX.equalToSuperview()
//            make.width.height.equalTo(100)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(8)
//            make.leading.trailing.equalToSuperview().inset(12)
//        }
//        
//        priceLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(4)
//            make.centerX.equalToSuperview()
//        }
//        
//        addButton.snp.makeConstraints { make in
//            make.top.equalTo(priceLabel.snp.bottom).offset(8)
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-12)
//        }
//        
//        containerView.snp.makeConstraints { make in
//            make.height.equalTo(200)
//        }
//        
//        return containerView
//    }
//}
//
//// MARK: - CategoryView Delegate
//extension ViewController: CategoryViewDelegate {
//    func categoryDidChange(_ category: CollectionViewTestMenuCategory) {
//        selectedCategory = category
//    }
//}

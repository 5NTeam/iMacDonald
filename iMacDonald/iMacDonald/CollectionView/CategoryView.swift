//
//  CategoryView.swift
//  iMacDonald
//
//  Created by 장상경 on 11/26/24.
//
//  맥도날드 앱의 상단 메뉴 카테고리를 구현한 커스텀 뷰입니다.
//  앱 로고와 가로 스크롤 가능한 카테고리 버튼들을 포함합니다.
//  사용자가 카테고리를 선택하면 메인 화면의 메뉴 필터링에 반영됩니다.

import UIKit
import SnapKit

/// 카테고리 선택 변경을 상위 뷰에 전달하기 위한 델리게이트 프로토콜
protocol CategoryViewDelegate: AnyObject {
    /// 카테고리가 변경되었을 때 호출되는 메서드
    /// - Parameter category: 새로 선택된 카테고리
    func categoryDidChange(_ category: Categorys)
    
    func showEasterEggs()
}

/// 앱 상단의 카테고리 선택 UI를 구현한 커스텀 뷰
/// 앱 로고와 가로 스크롤 가능한 카테고리 컬렉션뷰로 구성됩니다.
final class CategoryView: UIView {
    
    // MARK: - Properties
    /// 카테고리 버튼들을 가로 스크롤로 표시하는 컬렉션뷰
    private var collectionView: UICollectionView
    
    /// 앱 로고를 표시하는 레이블
    private let titleLogo = UILabel()
    
    private let easterEggsButton = UIButton()
    private var easterEggsCount = 0
    
    /// 현재 선택된 카테고리 상태
    private var state: Categorys = .all
    
    /// 현재 선택된 카테고리의 인덱스
    private var currentState: Int = 0
    
    /// 카테고리 변경 이벤트를 전달하기 위한 델리게이트
    weak var delegate: CategoryViewDelegate?
    
    // MARK: - Initialization
    /// 카테고리뷰의 기본 초기화 메서드
    /// 컬렉션뷰의 레이아웃을 설정하고 UI를 구성합니다.
    /// - Parameter frame: 뷰의 프레임 (기본값 .zero)
    override init(frame: CGRect) {
        // 컬렉션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal           // 가로 스크롤
        layout.itemSize = CGSize(width: 100, height: 40)  // 각 카테고리 버튼 크기
        layout.minimumInteritemSpacing = 10           // 버튼 간 간격
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        
        setupUIConfig()
    }
    
    /// 스토리보드를 통한 초기화를 지원하는 필수 생성자
    /// - Parameter coder: 스토리보드에서 전달되는 디코더
    required init?(coder: NSCoder) {
        // 컬렉션뷰 레이아웃 설정 (init(frame:)과 동일)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumInteritemSpacing = 10
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
        
        setupUIConfig()
    }
    
    /// UI 구성요소들의 초기 설정을 수행하는 메서드
    private func setupUIConfig() {
        setupLogo()          // 로고 설정
        setupCollectionView() // 컬렉션뷰 설정
        setupEasterEggs()
    }
}

// MARK: - UI Setup Methods
private extension CategoryView {
    func setupEasterEggs() {
        easterEggsButton.backgroundColor = .clear
        easterEggsButton.addTarget(self, action: #selector(showEasterEggs), for: .touchDown)
        self.addSubview(easterEggsButton)
        
        easterEggsButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 가운데 정렬
            $0.top.equalToSuperview()      // 상단에 배치
            $0.height.equalTo(50)          // 높이 50pt
        }
    }
    
    @objc func showEasterEggs() {
        guard self.easterEggsCount == 5 else {
            self.easterEggsCount += 1
            return
        }
        self.delegate?.showEasterEggs()
        self.easterEggsCount = 0
    }
    
    /// 앱 로고 UI를 설정하는 메서드
    /// 'iMacDonald' 텍스트를 특정 스타일로 표시합니다.
    func setupLogo() {
        titleLogo.text = "iMacDonald"
        titleLogo.font = UIFont.systemFont(ofSize: 30, weight: .black)  // 굵은 30pt 폰트
        titleLogo.backgroundColor = UIColor.clear
        titleLogo.textAlignment = .center
        titleLogo.textColor = UIColor.personal
        self.addSubview(titleLogo)
        
        // 로고 레이블 제약조건 설정
        titleLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()  // 가운데 정렬
            $0.top.equalToSuperview()      // 상단에 배치
            $0.height.equalTo(50)          // 높이 50pt
        }
    }
    
    /// 카테고리 컬렉션뷰를 설정하는 메서드
    /// 가로 스크롤 가능한 카테고리 버튼들을 구성합니다.
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // 커스텀 셀 등록
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        // 스크롤바 숨김 처리
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        self.addSubview(collectionView)
        
        // 컬렉션뷰 제약조건 설정
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLogo.snp.bottom)        // 로고 아래 배치
            $0.leading.equalToSuperview().offset(20)     // 좌우 20pt 여백
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)                        // 높이 50pt
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    /// 컬렉션뷰의 아이템 개수를 반환하는 메서드
    /// Categorys enum의 모든 케이스 수만큼 반환합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categorys.allCases.count
    }
    
    /// 각 카테고리 셀을 구성하는 메서드
    /// - Parameters:
    ///   - collectionView: 컬렉션뷰 인스턴스
    ///   - indexPath: 셀의 위치 정보
    /// - Returns: 구성된 카테고리 셀
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        
        // 카테고리 레이블 설정
        cell.categoryLabelConfig(indexPath.item)
        
        // 현재 선택된 카테고리 강조 표시
        let isSelected: Bool = indexPath.item == currentState
        cell.selectCategory(isSelected)
        
        // 선택된 카테고리가 잘 보이도록 자동 스크롤 처리
        if isSelected {
            let targetOffsetX: CGFloat
            
            // 스크롤 위치 계산
            if cell.frame.origin.x < collectionView.contentSize.width - collectionView.bounds.width {
                targetOffsetX = indexPath.item != 0 ? cell.frame.origin.x - 70 : cell.frame.origin.x
            } else {
                targetOffsetX = collectionView.contentSize.width - collectionView.bounds.width
            }
            
            // 부드러운 스크롤 애니메이션
            collectionView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: true)
        }
        
        return cell
    }
    
    /// 카테고리 셀이 선택되었을 때 호출되는 메서드
    /// 선택된 카테고리에 따라 상태를 업데이트하고 델리게이트에 통보합니다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 선택된 인덱스에 따라 카테고리 상태 업데이트
        switch indexPath.item {
        case 0: self.state = .all
        case 1: self.state = .burger
        case 2: self.state = .chicken
        case 3: self.state = .vegan
        case 4: self.state = .side
        case 5: self.state = .drink
        default: break
        }
        
        // 현재 상태 인덱스 업데이트
        switch self.state {
        case .all: self.currentState = 0
        case .burger: self.currentState = 1
        case .chicken: self.currentState = 2
        case .vegan: self.currentState = 3
        case .side: self.currentState = 4
        case .drink: self.currentState = 5
        }
        
        // UI 업데이트
        collectionView.reloadData()
        
        // 델리게이트에 카테고리 변경 통보
        delegate?.categoryDidChange(self.state)
    }
}

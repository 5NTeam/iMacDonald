//
//  CardView.swift
//  iMacDonald
//
//  메뉴 아이템을 카드 형태로 표시하는 커스텀 뷰를 구현한 파일입니다.
//  각 카드는 메뉴 이미지, 이름, 가격을 표시하며, 장바구니 추가 버튼을 포함합니다.
//  다크모드/라이트모드에 따른 동적 스타일링을 지원합니다.

import UIKit
import SnapKit

/// 카드뷰의 버튼 탭 이벤트를 처리하기 위한 델리게이트 프로토콜
protocol CardViewDelegate: AnyObject {
    /// 카드의 추가 버튼이 탭되었을 때 호출되는 메서드
    /// - Parameter data: 선택된 메뉴의 정보
    func cardViewButtonTapped(_ data: MenuData)
}

/// 메뉴 아이템을 표시하는 카드 형태의 커스텀 뷰
class CardView: UIView {
    
    // MARK: - Properties
    /// 버튼 탭 이벤트를 처리할 델리게이트
    weak var delegate: CardViewDelegate?

    // MARK: - UI Components
    /// 메뉴 이미지를 표시하는 이미지뷰
    private let imageView = UIImageView()
    
    /// 메뉴 이름을 표시하는 레이블
    private let nameLabel = UILabel()
    
    /// 메뉴 가격을 표시하는 레이블
    private let priceLabel = UILabel()
    
    /// 장바구니 추가 버튼
    private let button = UIButton()
    
    // MARK: - Private Properties
    /// 현재 표시중인 메뉴 이름
    private var itemName: String = ""
    
    /// 현재 표시중인 메뉴 가격
    private var itemPrice: Int = 0
    
    /// 현재 표시중인 메뉴 이미지
    private var itemImage: UIImage?
    
    // MARK: - Initialization
    /// 카드뷰를 초기화하는 메서드
    /// - Parameters:
    ///   - name: 메뉴 이름
    ///   - price: 메뉴 가격
    ///   - image: 메뉴 이미지
    init(name: String, price: Int, image: UIImage?) {
        super.init(frame: .zero)
        itemName = name
        itemPrice = price
        itemImage = image
        setupView()                                    // UI 구성요소 초기화
        configure(name: name, price: price, image: image)  // 데이터 설정
        registerTraitChangeHandler()                   // 다크모드 감지 설정
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerTraitChangeHandler()
    }
    
    // MARK: - UI Setup
    /// 카드뷰의 UI를 설정하는 메서드
    private func setupView() {
        // 카드뷰 스타일 설정
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "CardViewColor")

        setupImageView()    // 이미지뷰 설정
        setupNameLabel()    // 이름 레이블 설정
        setupPriceLabel()   // 가격 레이블 설정
        setupButton()       // 버튼 설정
        setupConstraints()  // 제약조건 설정
    }
    
    /// 이미지뷰 설정 메서드
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemBackground
        addSubview(imageView)
    }
    
    /// 메뉴 이름 레이블 설정 메서드
    private func setupNameLabel() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = UIColor.dynamicTextColor
        nameLabel.numberOfLines = 0           // 여러 줄 표시 허용
        nameLabel.lineBreakMode = .byWordWrapping
        addSubview(nameLabel)
    }
    
    /// 가격 레이블 설정 메서드
    private func setupPriceLabel() {
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textColor = UIColor.dynamicTextColor
        addSubview(priceLabel)
    }
    
    /// 추가 버튼 설정 메서드
    private func setupButton() {
        let buttonImage = UIImage(systemName: "plus.circle.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large))
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .top
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "PersonalColor")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
    }
    
    /// UI 요소들의 제약조건을 설정하는 메서드
    private func setupConstraints() {
        // 이미지뷰 제약조건: 상단 전체 영역의 60% 차지
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        // 메뉴 이름 레이블 제약조건
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        // 가격 레이블 제약조건
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10)
        }
        
        // 추가 버튼 제약조건
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
    }
    
    // MARK: - Data Configuration
    /// 카드뷰의 데이터를 설정하는 메서드
    /// - Parameters:
    ///   - name: 메뉴 이름
    ///   - price: 메뉴 가격
    ///   - image: 메뉴 이미지
    private func configure(name: String, price: Int, image: UIImage?) {
        nameLabel.text = name
        priceLabel.text = "\(price.formattedWithSeparator)원"
        imageView.image = image
    }
    
    /// 버튼 탭 이벤트 처리 메서드
    @objc private func buttonTapped() {
        let cardInfo = MenuData(name: itemName, price: itemPrice, image: itemImage, category: nil)
        delegate?.cardViewButtonTapped(cardInfo)
    }
    
    // MARK: - Dark Mode Handling
    /// 다크모드 변경 감지 시 호출되는 메서드
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBorderColor()
        }
    }
    
    /// 테마에 따른 테두리 색상 업데이트 메서드
    private func updateBorderColor() {
        self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
    }
    
    /// iOS 17 이상에서 테마 변경 감지 설정 메서드
    private func registerTraitChangeHandler() {
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
                self.updateBorderColor()
            }
        }
    }
}

// MARK: - UIColor Extension
extension UIColor {
    /// 테마에 따라 동적으로 변하는 텍스트 색상
    static var dynamicTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
}

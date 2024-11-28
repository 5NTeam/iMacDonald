import UIKit
import SnapKit

protocol CardViewDelegate: AnyObject {
    func cardViewButtonTapped(_ data: MenuData)
}

class CardView: UIView {
    
    // Delegate property
    weak var delegate: CardViewDelegate?

    // CardView의 구성요소 이미지, 레이블 2개, 버튼 1개 객체 생성
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let button = UIButton()
    
    private var itemName: String = ""
    private var itemPrice: Int = 0
    private var itemImage: UIImage?
    
    // 메뉴 이름, 가격, 이미지를 가지는 객체 생성하고 초기화
    init(name: String, price: Int, image: UIImage?) {
        super.init(frame: .zero)
        itemName = name
        itemPrice = price
        itemImage = image // 이미지가 넘어가는게 확인되는게 아니면 이미지 이름을 넘기면 되고 , MenuData 구조체를 재사용하지말고 새로 구조체를 만들자
        setupView() // 뷰
        configure(name: name, price: price, image: image) // 데이터
        registerTraitChangeHandler() // iOS 17 이상에서 Trait 감지
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerTraitChangeHandler()
    }
    
    // 카드 뷰 UI 설정
    private func setupView() {
        // 카드뷰 스타일 설정
        self.clipsToBounds = true
        self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(named: "CardViewColor")

        // 이미지뷰 설정
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemBackground
        addSubview(imageView)
        
        // 메뉴이름 레이블 설정
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = UIColor.dynamicTextColor
        nameLabel.numberOfLines = 0 // 여러 줄로 표시 가능
        nameLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈
        addSubview(nameLabel)
        
        // 가격 레이블 설정
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textColor = UIColor.dynamicTextColor
        addSubview(priceLabel)
        
        // 버튼 설정
        let buttonImage = UIImage(systemName: "plus.circle.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large))
        // 이미지가 버튼 크기에 맞게 조정되도록 설정
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .top
        button.setImage(buttonImage, for: .normal)
        button.tintColor = UIColor(named: "PersonalColor")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addSubview(button)
        
        // 제약 조건 설정
        setupConstraints()
    }
    
    // 카드뷰의 요소 이미지뷰, 메뉴이름, 가격, 버튼 제약 조건 설정 메서드
    private func setupConstraints() {
        // 이미지 제약 조건
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6) // 이미지뷰 높이: 카드뷰 높이의 60%
        }
        // 메뉴이름 제약 조건
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10) // 버튼과 겹치지 않도록 설정
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        // 가격 제약 조건
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.trailing.lessThanOrEqualTo(button.snp.leading).offset(-10) // 버튼과 겹치지 않도록 설정
        }
        // 버튼 제약 조건
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-10) // 카드뷰 오른쪽에서 10pt
            make.centerY.equalTo(priceLabel.snp.centerY) // 가격과 수평
            make.width.equalToSuperview().multipliedBy(0.2) // 카드뷰 너비의 20%
            make.height.equalToSuperview().multipliedBy(0.2) // 카드뷰 높이의 20%
        }
    }
    
    // 데이터 구성
    private func configure(name: String, price: Int, image: UIImage?) {
        nameLabel.text = name
        priceLabel.text = "\(price)원"
        imageView.image = image
    }
    
    // 버튼이 눌렸을 때 호출되는 메서드
    @objc private func buttonTapped() {
        let cardInfo = MenuData(name: itemName, price: itemPrice, image: itemImage , category: nil ) // MenuData 구조체 재사용해서 담아서 보내줌
        delegate?.cardViewButtonTapped(cardInfo)
    }
    
    
// 다크/라이트 모드 변경 시 호출되는 메서드
   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       super.traitCollectionDidChange(previousTraitCollection)

       // 색상 외형 변경이 있는 경우 업데이트
       if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
           updateBorderColor()
       }
   }
    
// 보더 색상 업데이트 메서드
    private func updateBorderColor() {
        // 다크 모드와 라이트 모드에 따라 색상 설정
        if self.traitCollection.userInterfaceStyle == .dark {
            self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
        } else {
            self.layer.borderColor = UIColor(named: "CardViewShadowColor")?.cgColor
        }
    }
    // iOS 17 이상에서 Trait 변경 감지 설정
    private func registerTraitChangeHandler() {
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
                self.updateBorderColor()
            }
        }
    }
}

// 기본은 블랙, 다크모드일 시 화이트로 색상을 변경해주는 메서드 정의
extension UIColor {
    static var dynamicTextColor: UIColor {
        return UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
    }
}



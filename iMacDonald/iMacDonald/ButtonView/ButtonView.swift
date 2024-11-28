/**
 * 작성자: 양정무
 * 파일명: ButtonView.swift
 * 기능: 결제 정보 표시 및 결제/취소 버튼을 포함하는 하단 뷰
 * 최종수정일: 2024.11.27
 */

import UIKit
import SnapKit

// MARK: - Delegate Protocol
/**
 * 버튼 뷰의 버튼 동작을 처리하기 위한 델리게이트 프로토콜
 */
protocol ButtonViewDelegate: AnyObject {
    /// 취소 버튼 탭 시 호출되는 메서드
    func didTapCancelButton()
    /// 결제 버튼 탭 시 호출되는 메서드
    func didTapPaymentButton()
}

class ButtonView: UIView  {
    // MARK: - Constants
    /**
     * 뷰에서 사용되는 상수값 모음
     * cornerRadius: 버튼의 모서리 둥글기 값
     * buttonHeight: 버튼의 높이
     * horizontalPadding: 좌우 여백
     * stackViewSpacing: 스택뷰 내부 아이템 간격
     * fontSize: 기본 폰트 크기
     * infoStackViewWidth: 정보 스택뷰의 너비
     */
    private enum Constants {
        static let cornerRadius: CGFloat = 25
        static let buttonHeight: CGFloat = 50
        static let horizontalPadding: CGFloat = 16
        static let stackViewSpacing: CGFloat = 12
        static let fontSize: CGFloat = 16
        static let infoStackViewWidth: CGFloat = 350
    }
    
    // MARK: - Properties
    /// 체크아웃 뷰 델리게이트
    weak var delegate: ButtonViewDelegate?
    
    /// 총 수량을 표시하는 레이블
    private let totalQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    /// 총 금액을 표시하는 레이블
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    /// 정보를 표시하는 수평 스택뷰
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    /// 취소 버튼
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.personal, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.personal.cgColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                        action: #selector(cancelButtonTapped),
                        for: .touchUpInside)
        button.isUserInteractionEnabled = true  // 추가
        applyShadow(to: button)
        return button
    }()
    
    // 다크모드 전환 시 호출되는 메서드
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // borderColor 업데이트
        cancelButton.layer.borderColor = UIColor.personal.cgColor
    }
    
    /// 결제 버튼
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        button.backgroundColor = UIColor.personal
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                        action: #selector(paymentButtonTapped),
                        for: .touchUpInside)
        button.isUserInteractionEnabled = true  // 추가
        applyShadow(to: button)
        return button
    }()
    
    /// 버튼을 담는 수평 스택뷰
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true  // 추가
        setupUI()
        setupAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    /**
     * UI 초기 설정을 수행하는 메서드
     */
    private func setupUI() {
        backgroundColor = .systemBackground
        configureSubviews()
        setupConstraints()
    }
    
    /**
     * 서브뷰들을 구성하고 추가하는 메서드
     */
    private func configureSubviews() {
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(totalQuantityLabel)
        infoStackView.addArrangedSubview(totalAmountLabel)
        
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(paymentButton)
    }
    
    /**
     * 오토레이아웃 제약조건을 설정하는 메서드
     */
    private func setupConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(Constants.infoStackViewWidth)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalPadding)
            make.right.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalPadding)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalPadding)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
    /**
     * 접근성 레이블을 설정하는 메서드
     */
    private func setupAccessibility() {
        // 취소 버튼을 눌렀을 때 "주문 취소하기"라고 읽어줍니다
        cancelButton.accessibilityLabel = "주문 취소하기"
        
        // 결제 버튼을 눌렀을 때 "결제 진행하기"라고 읽어줍니다
        paymentButton.accessibilityLabel = "결제 진행하기"
        
        // 수량 표시 부분을 읽을 때 "총 주문 수량"이라고 읽어줍니다
        totalQuantityLabel.accessibilityLabel = "총 주문 수량"
        
        // 금액 표시 부분을 읽을 때 "총 결제 금액"이라고 읽어줍니다
        totalAmountLabel.accessibilityLabel = "총 결제 금액"
    }
    
    /**
     * 버튼에 그림자를 적용하는 메서드
     * - Parameter button: 그림자를 적용할 버튼
     */
    private func applyShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.1
    }
    
    // MARK: - Action Methods
    /**
     * 취소 버튼 탭 이벤트 처리 메서드
     */
    @objc private func cancelButtonTapped() {
        print("ButtonView: Cancel button tapped")
        delegate?.didTapCancelButton()
    }

    
    /**
     * 결제 버튼 탭 이벤트 처리 메서드
     */
    @objc private func paymentButtonTapped() {
        print("ButtonView: Payment button tapped")
        delegate?.didTapPaymentButton()
    }
    
    // MARK: - Public Methods
    /**
     * 총 수량을 업데이트하는 메서드
     * - Parameter quantity: 표시할 총 수량
     */
    func updateTotalQuantity(_ quantity: Int) {
        totalQuantityLabel.text = "총 \(quantity)개"
    }
    
    /**
     * 총 금액을 업데이트하는 메서드
     * - Parameter amount: 표시할 총 금액
     */
    func updateTotalAmount(_ amount: Int) {
        totalAmountLabel.text = "\(amount.formattedWithSeparator)원"
    }
}

// MARK: - Extensions
/**
 * Int 타입에 대한 확장
 * 숫자 포맷팅 기능 추가
 */
extension Int {
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var formattedWithSeparator: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

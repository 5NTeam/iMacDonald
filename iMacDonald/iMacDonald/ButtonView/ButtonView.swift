//
//  ButtonView.swift
//  iMacDonald
//
/**
 * @class ButtonView
 * @description 주문 결제 화면의 하단에 표시되는 뷰입니다.
 * - 주문 총 수량과 금액을 표시
 * - 주문 취소와 결제 진행을 위한 버튼 제공
 * - 접근성 지원을 위한 VoiceOver 레이블 포함
 *
 * @author 양정무
 * @last_modified 2024.11.27
 */

import UIKit
import SnapKit

// MARK: - Delegate Protocol
/**
 * 버튼 뷰의 사용자 상호작용을 상위 뷰에 전달하기 위한 프로토콜
 * 주문 취소와 결제 진행 이벤트를 처리합니다.
 */
protocol ButtonViewDelegate: AnyObject {
    /// 사용자가 취소 버튼을 탭했을 때 호출
    /// 장바구니의 모든 항목을 삭제하는 동작을 수행합니다.
    func didTapCancelButton()
    
    /// 사용자가 결제 버튼을 탭했을 때 호출
    /// 결제 프로세스를 시작하는 동작을 수행합니다.
    func didTapPaymentButton()
}

/// 결제 정보와 버튼을 표시하는 커스텀 뷰
class ButtonView: UIView  {
    // MARK: - Constants
    /**
     * 뷰의 레이아웃과 스타일링에 사용되는 상수값들
     * 일관된 UI를 유지하고 유지보수를 용이하게 합니다.
     */
    private enum Constants {
        /// 버튼의 모서리 둥글기 (25pt)
        static let cornerRadius: CGFloat = 25
        /// 버튼의 기본 높이 (50pt)
        static let buttonHeight: CGFloat = 50
        /// 좌우 여백 (16pt)
        static let horizontalPadding: CGFloat = 16
        /// 스택뷰 내부 요소 간격 (12pt)
        static let stackViewSpacing: CGFloat = 12
        /// 기본 폰트 크기 (16pt)
        static let fontSize: CGFloat = 16
        /// 정보 스택뷰의 고정 너비 (350pt)
        static let infoStackViewWidth: CGFloat = 350
    }
    
    // MARK: - Properties
    /// 버튼 동작을 위임받을 델리게이트
    weak var delegate: ButtonViewDelegate?
    
    // MARK: - UI Components
    /// 총 주문 수량을 표시하는 레이블
    /// "총 N개" 형식으로 표시됩니다.
    private let totalQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    /// 총 결제 금액을 표시하는 레이블
    /// "N,NNN원" 형식으로 표시됩니다.
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    /// 수량과 금액 정보를 담는 수평 스택뷰
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    /// 주문 취소 버튼
    /// 테두리가 있는 흰색 배경의 버튼입니다.
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.personal, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        button.backgroundColor = .systemBackground
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.personal.cgColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        applyShadow(to: button)
        return button
    }()
    
    /// 다크모드 변경 시 테두리 색상 업데이트
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        cancelButton.layer.borderColor = UIColor.personal.cgColor
    }
    
    /// 결제 버튼
    /// 강조색 배경의 버튼입니다.
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        button.backgroundColor = UIColor.personal
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        applyShadow(to: button)
        return button
    }()
    
    /// 취소와 결제 버튼을 포함하는 수평 스택뷰
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Lifecycle Methods
    /// 뷰 초기화 메서드
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        setupUI()
        setupAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    /**
     * UI 초기 설정을 수행하는 메서드
     * 배경색 설정 및 하위 뷰 구성을 담당합니다.
     */
    private func setupUI() {
        backgroundColor = .systemBackground
        configureSubviews()
        setupConstraints()
    }
    
    /**
     * 서브뷰들을 구성하고 계층 구조를 설정하는 메서드
     * 스택뷰에 레이블과 버튼들을 추가합니다.
     */
    private func configureSubviews() {
        self.addSubview(infoStackView)
        infoStackView.addArrangedSubview(totalQuantityLabel)
        infoStackView.addArrangedSubview(totalAmountLabel)
        
        self.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(paymentButton)
    }
    
    /**
     * 오토레이아웃 제약조건을 설정하는 메서드
     * SnapKit을 사용하여 뷰의 레이아웃을 정의합니다.
     */
    private func setupConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStackView.snp.top).offset(-15)
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(Constants.infoStackViewWidth)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(Constants.horizontalPadding)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalPadding)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-Constants.horizontalPadding)
            make.height.equalTo(Constants.buttonHeight)
        }
    }
    
    /**
     * 접근성 레이블을 설정하는 메서드
     * VoiceOver 사용자를 위한 접근성 레이블을 설정합니다.
     */
    private func setupAccessibility() {
        cancelButton.accessibilityLabel = "주문 취소하기"
        paymentButton.accessibilityLabel = "결제 진행하기"
        totalQuantityLabel.accessibilityLabel = "총 주문 수량"
        totalAmountLabel.accessibilityLabel = "총 결제 금액"
    }
    
    /**
     * 버튼에 그림자 효과를 적용하는 메서드
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
     * 델리게이트를 통해 취소 이벤트를 전달합니다.
     */
    @objc private func cancelButtonTapped() {
        print("ButtonView: Cancel button tapped")
        delegate?.didTapCancelButton()
    }
    
    /**
     * 결제 버튼 탭 이벤트 처리 메서드
     * 델리게이트를 통해 결제 이벤트를 전달합니다.
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
        self.totalQuantityLabel.text = "총 \(quantity)개"
        self.layoutIfNeeded()
    }
    
    /**
     * 총 금액을 업데이트하는 메서드
     * - Parameter amount: 표시할 총 금액
     */
    func updateTotalAmount(_ amount: Int) {
        self.totalAmountLabel.text = "\(amount.formattedWithSeparator)원"
        self.layoutIfNeeded()
    }
}

// MARK: - Extensions
/**
 * Int 타입에 대한 확장
 * 숫자를 천 단위 구분자가 포함된 문자열로 변환하는 기능을 추가합니다.
 */
extension Int {
    /// 천 단위 구분자를 위한 NumberFormatter
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    /// 천 단위 구분자가 포함된 문자열로 변환하는 계산 프로퍼티
    var formattedWithSeparator: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

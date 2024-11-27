/**
* 작성자: 양정무
* 파일명: ButtonView.swift
* 기능: 결제 정보 표시 및 결제/취소 버튼을 포함하는 하단 뷰
*/

import UIKit
import SnapKit

// MARK: - Delegate Protocol
protocol CheckoutViewDelegate: AnyObject {
    func didTapCancelButton()
    func didTapPaymentButton()
}

class CheckoutView: UIView {
    // MARK: - Constants
    private enum Constants {
        static let cornerRadius: CGFloat = 25
        static let buttonHeight: CGFloat = 50
        static let horizontalPadding: CGFloat = 16
        static let stackViewSpacing: CGFloat = 12
        static let fontSize: CGFloat = 16
        static let infoStackViewWidth: CGFloat = 350
    }
    
    // MARK: - Properties
    weak var delegate: CheckoutViewDelegate?
    
    private let totalQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                        action: #selector(cancelButtonTapped),
                        for: .touchUpInside)
        applyShadow(to: button)
        return button
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self,
                        action: #selector(paymentButtonTapped),
                        for: .touchUpInside)
        applyShadow(to: button)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .white
        configureSubviews()
        setupConstraints()
    }
    
    private func configureSubviews() {
        addSubview(infoStackView)
        infoStackView.addArrangedSubview(totalQuantityLabel)
        infoStackView.addArrangedSubview(totalAmountLabel)
        
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(paymentButton)
    }
    
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
    
    private func setupAccessibility() {
        cancelButton.accessibilityLabel = "주문 취소하기"
        paymentButton.accessibilityLabel = "결제 진행하기"
        totalQuantityLabel.accessibilityLabel = "총 주문 수량"
        totalAmountLabel.accessibilityLabel = "총 결제 금액"
    }
    
    private func applyShadow(to button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.1
    }
    
    // MARK: - Actions
    @objc private func cancelButtonTapped() {
        delegate?.didTapCancelButton()
    }
    
    @objc private func paymentButtonTapped() {
        delegate?.didTapPaymentButton()
    }
    
    // MARK: - Public Methods
    func updateTotalQuantity(_ quantity: Int) {
        totalQuantityLabel.text = "총 \(quantity)개"
    }
    
    func updateTotalAmount(_ amount: Int) {
        totalAmountLabel.text = "\(amount.formattedWithSeparator)원"
    }
}

// MARK: - Extensions
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

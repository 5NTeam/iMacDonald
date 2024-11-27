/**
* 작성자: 양정무
* 파일명: ButtonView.swift
* 기능: 결제 정보 표시 및 결제/취소 버튼을 포함하는 하단 뷰
*/

import UIKit

import SnapKit

class CheckoutView: UIView {
    // MARK: - Properties
    private let totalQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
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
        button.layer.cornerRadius = 25
        button.addTarget(self,
                action: #selector(cancelButtonTapped),
                for: .touchUpInside)
        return button
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self,
                action: #selector(paymentButtonTapped),
                for: .touchUpInside)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
            make.centerX.equalToSuperview()  // 중앙 정렬 유지
            make.top.equalToSuperview().offset(10)  // 상단 여백 추가
            make.width.equalTo(350)  // 적절한 너비 설정 (이 값을 조절하여 간격 조정 가능)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide).offset(16)  // safe area 기준으로 변경
            make.right.equalTo(safeAreaLayoutGuide).offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    @objc private func cancelButtonTapped() {
        // 취소 버튼 동작 구현
    }
    
    @objc private func paymentButtonTapped() {
        // 결제 버튼 동작 구현
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
    var formattedWithSeparator: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

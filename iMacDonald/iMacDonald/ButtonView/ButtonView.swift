//
//  ButtonView.swift
//  iMacDonald
//
//  Created by 유태호 on 11/25/24.
//


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
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.setTitle("결제하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
        
        // Add subviews
        addSubview(totalQuantityLabel)
        addSubview(totalAmountLabel)
        addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(paymentButton)
        
        // Setup constraints
        totalQuantityLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
        }
        
        totalAmountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(totalQuantityLabel)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Public Methods
    func updateTotalQuantity(_ quantity: Int) {
        totalQuantityLabel.text = "총 수량: \(quantity)개"
    }
    
    func updateTotalAmount(_ amount: Int) {
        totalAmountLabel.text = "총 결제금액: ₩\(amount.formattedWithComma)"
    }
    
    // MARK: - Actions
    @objc private func cancelButtonTapped() {
        // 취소 로직 구현
    }
    
    @objc private func paymentButtonTapped() {
        // 결제 로직 구현
    }
}

// MARK: - Extensions
extension Int {
    var formattedWithComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? String(self)
    }
}


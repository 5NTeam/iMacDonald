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
        stackView.spacing = 16
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
    /**
    * 기능: UI 컴포넌트들을 초기화하고 제약조건을 설정하는 메서드
    */
    private func setupUI() {
        backgroundColor = .white
        
        configureSubviews()
        setupConstraints()
    }
    
    /**
    * 기능: 서브뷰들을 추가하고 구성하는 메서드
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
    * 기능: Auto Layout 제약조건을 설정하는 메서드
    */
    private func setupConstraints() {
        infoStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-16)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Actions
    /**
    * 기능: 취소 버튼 탭 이벤트 처리
    */
    @objc private func cancelButtonTapped() {
        // 취소 버튼 동작 구현
    }
    
    /**
    * 기능: 결제 버튼 탭 이벤트 처리
    */
    @objc private func paymentButtonTapped() {
        // 결제 버튼 동작 구현
    }
    
    // MARK: - Public Methods
    /**
    * 기능: 총 수량을 업데이트하는 메서드
    * @param quantity: 표시할 총 수량
    */
    func updateTotalQuantity(_ quantity: Int) {
        totalQuantityLabel.text = "총 \(quantity)개"
    }
    
    /**
    * 기능: 총 금액을 업데이트하는 메서드
    * @param amount: 표시할 총 금액
    */
    func updateTotalAmount(_ amount: Int) {
        totalAmountLabel.text = "\(amount.formattedWithSeparator)원"
    }
}

// MARK: - Extensions
extension Int {
    /**
    * 기능: 숫자를 천 단위 구분자가 포함된 문자열로 변환
    * @return: 천 단위 구분자가 포함된 문자열
    */
    var formattedWithSeparator: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

import UIKit
import SnapKit

class MenuViewController: UIViewController, ButtonViewDelegate {
    // MARK: - Properties
    private let buttonView = ButtonView() // 변수명을 소문자로 시작하도록 수정
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // delegate 설정
        buttonView.delegate = self
        
        // 테스트를 위한 예시 데이터
        updateTotalQuantity(3)
        updateTotalAmount(12500)
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(buttonView)
        
        buttonView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    // MARK: - Public Methods
    func updateTotalQuantity(_ quantity: Int) {
        buttonView.updateTotalQuantity(quantity)
    }
    
    func updateTotalAmount(_ amount: Int) {
        buttonView.updateTotalAmount(amount)
    }
    
    // MARK: - ButtonViewDelegate Methods
    func didTapCancelButton() {
        let alertController = UIAlertController(
            title: "주문 취소",
            message: "주문을 취소하시겠습니까?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "아니오",
            style: .cancel
        )
        
        let confirmAction = UIAlertAction(
            title: "예",
            style: .destructive
        ) { _ in
            // 취소 처리 로직
            print("주문이 취소되었습니다.")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func didTapPaymentButton() {
        let alertController = UIAlertController(
            title: "결제 확인",
            message: "결제를 진행하시겠습니까?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "아니요",
            style: .cancel
        )
        
        let confirmAction = UIAlertAction(
            title: "예",
            style: .destructive
        ) { _ in
            // 결제 처리 로직
            print("결제가 진행됩니다.")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}


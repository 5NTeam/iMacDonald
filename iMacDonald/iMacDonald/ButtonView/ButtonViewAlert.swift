//
//  AlertFunction.swift
//  iMacDonald
//
//  Created by YangJeongMu on 11/28/24.
//
//  앱에서 사용되는 알럿 다이얼로그를 관리하는 매니저 파일입니다.
//  장바구니 삭제, 결제 확인 등의 사용자 액션을 확인하는 알럿을 표시합니다.

import UIKit

/// 앱에서 사용되는 알럿 다이얼로그를 관리하는 열거형
/// 알럿 표시와 관련된 static 메서드들을 포함합니다.
enum AlertManager {
    
    /// 확인/취소 두 버튼이 있는 알럿을 표시하는 메서드
    /// 사용자의 중요한 액션을 확인하는 용도로 사용됩니다.
    /// - Parameters:
    ///   - viewController: 알럿을 표시할 뷰컨트롤러
    ///   - title: 알럿의 제목 (예: "주문 취소")
    ///   - message: 알럿의 본문 메시지
    ///   - confirmTitle: 확인 버튼의 텍스트 (기본값: "예")
    ///   - cancelTitle: 취소 버튼의 텍스트 (기본값: "아니오")
    ///   - confirmAction: 확인 버튼을 눌렀을 때 실행될 클로저
    /// - Note: 확인 버튼은 빨간색(.destructive)으로 표시되어 주의가 필요한 액션임을 나타냅니다.
    static func showAlert(
        from viewController: UIViewController,
        title: String,
        message: String,
        confirmTitle: String = "예",
        cancelTitle: String = "아니오",
        confirmAction: @escaping () -> Void
    ) {
        // 알럿 컨트롤러 생성
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // 취소 버튼 액션 생성
        // .cancel 스타일을 사용하여 기본 액션임을 표시
        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .cancel
        )
        
        // 확인 버튼 액션 생성
        // .destructive 스타일을 사용하여 주의가 필요한 액션임을 표시
        let confirmAction = UIAlertAction(
            title: confirmTitle,
            style: .destructive
        ) { _ in
            confirmAction()  // 전달받은 확인 액션 실행
        }
        
        // 알럿에 액션 버튼 추가
        alertController.addAction(cancelAction)   // 취소 버튼
        alertController.addAction(confirmAction)  // 확인 버튼
        
        // 알럿을 화면에 표시
        viewController.present(alertController, animated: true)
    }
    
    /// 결제 성공 시 표시되는 단일 버튼 알럿을 표시하는 메서드
    /// 사용자에게 결제 완료를 알리는 용도로 사용됩니다.
    /// - Parameters:
    ///   - viewController: 알럿을 표시할 뷰컨트롤러
    ///   - title: 알럿의 제목 (예: "결제 성공")
    ///   - message: 알럿의 본문 메시지
    ///   - confirmTitle: 확인 버튼의 텍스트 (기본값: "확인")
    /// - Note: 단일 버튼만 있는 알럿으로, 사용자가 확인하면 자동으로 닫힙니다.
    static func succesePayment(
        from viewController: UIViewController,
        title: String,
        message: String,
        confirmTitle: String = "확인"
    ) {
        // 알럿 컨트롤러 생성
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // 확인 버튼 액션 생성
        // .cancel 스타일을 사용하여 일반적인 확인 버튼임을 표시
        let cancelAction = UIAlertAction(
            title: confirmTitle,
            style: .cancel
        )
        
        // 알럿에 확인 버튼 추가
        alertController.addAction(cancelAction)
        
        // 알럿을 화면에 표시
        viewController.present(alertController, animated: true)
    }
}

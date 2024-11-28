//
//  Untitled.swift
//  iMacDonald
//
//  Created by YangJeongMu on 11/28/24.
//

// AlertFunction.swift

import UIKit

/**
 * 알럿을 표시하는 전역 함수
 * - Parameters:
 *   - viewController: 알럿을 표시할 뷰컨트롤러
 *   - title: 알럿 제목
 *   - message: 알럿 메시지
 *   - confirmTitle: 확인 버튼 텍스트
 *   - cancelTitle: 취소 버튼 텍스트
 *   - confirmAction: 확인 버튼 터치 시 실행될 클로저
 */
enum AlertManager {
    static func showAlert(
        from viewController: UIViewController,
        title: String,
        message: String,
        confirmTitle: String = "예",
        cancelTitle: String = "아니오",
        confirmAction: @escaping () -> Void
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // 취소 액션
        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .cancel
        )
        
        // 확인 액션
        let confirmAction = UIAlertAction(
            title: confirmTitle,
            style: .destructive
        ) { _ in
            confirmAction()
        }
        
        // 액션 추가
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        // 알럿 표시
        viewController.present(alertController, animated: true)
    }
    
    static func succesePayment(
        from viewController: UIViewController,
        title: String,
        message: String,
        confirmTitle: String = "확인"
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // 취소 액션
        let cancelAction = UIAlertAction(
            title: confirmTitle,
            style: .cancel
        )
        
        // 액션 추가
        alertController.addAction(cancelAction)
        
        // 알럿 표시
        viewController.present(alertController, animated: true)
    }
}

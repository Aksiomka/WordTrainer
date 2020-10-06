//
//  KeyboardObserver.swift
//  WordTrainer
//
//  Created by Svetlana Gladysheva on 18.08.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import SwiftUI


final class KeyboardObserver: ObservableObject {

    private var keyboardRect: CGRect = CGRect()
    private var keyboardIsHidden = true

    @Published var offset: CGFloat = 0

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func keyBoardWillShow(notification: Notification) {
        if keyboardIsHidden {
            keyboardIsHidden = false
            if let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect {
                keyboardRect = rect
                updateOffset()
            }
        }
    }

    @objc private func keyBoardDidHide(notification: Notification) {
        keyboardIsHidden = true
        updateOffset()
    }

    private func updateOffset() {
        if keyboardIsHidden {
            offset = 0
        } else {
            offset = -keyboardRect.height / 2
        }
    }
}

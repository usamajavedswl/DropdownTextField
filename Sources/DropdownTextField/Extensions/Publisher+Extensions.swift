//
//  File.swift
//  DropdownTextField
//
//  Created by Mian Usama on 16/09/2025.
//


import SwiftUI
import Combine

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let publisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .map { notification -> CGFloat in
                if let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return notification.name == UIResponder.keyboardWillHideNotification ? 0 : frame.height
                }
                return 0
            }
            .eraseToAnyPublisher()
        return publisher
    }
}

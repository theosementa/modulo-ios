//
//  KeyboardManager.swift
//  Core
//
//  Created by Theo Sementa on 25/03/2026.
//

import Combine
import SwiftUI

public class KeyboardManager: ObservableObject {
    @Published public var keyboardHeight: CGFloat = 0
    @Published public var isKeyboardVisible = false
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in
                guard let self = self,
                      let userInfo = notification.userInfo,
                      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }
                
                self.isKeyboardVisible = true
                self.keyboardHeight = keyboardFrame.height
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                withAnimation(.easeOut(duration: 0.3)) {
                    self.isKeyboardVisible = false
                    self.keyboardHeight = 0
                }
            }
            .store(in: &cancellables)
    }
}

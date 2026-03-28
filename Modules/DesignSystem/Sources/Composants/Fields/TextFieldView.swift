//
//  TextFieldView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI

public struct TextFieldView: View {
    
    // MARK: Dependencies
    @Binding var text: String
    let title: String
    let placeholder: String
    
    // MARK: States
    @FocusState private var isFocused: Bool
    
    // MARK: Init
    public init(
        text: Binding<String>,
        title: String,
        placeholder: String
    ) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
    }
    
    // MARK: - View
    public var body: some View {
        VStack(spacing: .zero) {
            Text(title)
                .font(.Label.largeMedium, color: .Text.secondary)
            TextField("", text: $text)
                .font(.Title.mediumMedium, color: .Text.primary)
                .focused($isFocused)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .overlay(condition: text.isReallyEmpty) {
                    Text(placeholder)
                        .font(.Title.mediumMedium, color: .Text.tertiary)
                }
                .submitLabel(.done)
        }
        .onTapGesture { isFocused.toggle() }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var text: String = ""
    TextFieldView(text: $text, title: "The title of the field", placeholder: "Hello World!")
}

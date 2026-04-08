//
//  SFSafariScreen.swift
//  DesignSystem
//
//  Created by Theo Sementa on 08/04/2026.
//

import SwiftUI
import SafariServices

public struct SFSafariScreen: UIViewControllerRepresentable {
    let url: URL

    public init(url: URL) {
        self.url = url
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    public func updateUIViewController(
        _ uiViewController: SFSafariViewController,
        context: UIViewControllerRepresentableContext<SFSafariScreen>) {
        // No need to do anything here
    }
}

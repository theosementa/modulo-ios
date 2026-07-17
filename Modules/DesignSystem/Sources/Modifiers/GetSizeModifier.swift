//
//  GetSizeModifier.swift
//  DesignSystem
//
//  Created by Theo Sementa on 17/07/2026.
//

import SwiftUI

public struct GetSizeModifier: ViewModifier {
    
    private let onlyOnLoad: Bool
    private var size: (_ size: CGSize) -> Void
    
    public init(onlyOnLoad: Bool, size: @escaping (_: CGSize) -> Void) {
        self.onlyOnLoad = onlyOnLoad
        self.size = size
    }
    
    @State private var isLoaded: Bool = false
    
    public func body(content: Content) -> some View {
        return content.background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        if onlyOnLoad == false || isLoaded == false {
                            size(proxy.size)
                            isLoaded = true
                        }
                    }
            }
        )
    }
}

extension View {
    public func getSize(onlyOnLoad: Bool = false, size: @escaping (CGSize) -> Void) -> some View {
        return modifier(GetSizeModifier(onlyOnLoad: onlyOnLoad, size: size))
    }
}

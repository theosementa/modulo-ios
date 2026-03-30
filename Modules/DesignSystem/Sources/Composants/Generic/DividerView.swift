//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

public struct DividerView: View {
    
    public init() { }
    
    // MARK: - View
    public var body: some View {
        Line()
            .stroke(Color.Text.tertiary, style: .init(lineWidth: 2.5, lineCap: .round, lineJoin: .round, dash: [0.5, 8]))
            .frame(height: 2)
    }
    
}

// MARK: - Preview
#Preview {
    DividerView()
}

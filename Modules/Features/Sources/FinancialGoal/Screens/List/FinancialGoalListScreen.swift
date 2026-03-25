//
//  SwiftUIView.swift
//  Features
//
//  Created by Theo Sementa on 22/03/2026.
//

import SwiftUI
import DesignSystem

public struct FinancialGoalListScreen: View {
    
    public init() { }
    
    // MARK: - View
    public var body: some View {
        List {
            
        }
        .background(Color.Background.primary)
//        .overlay {
//            ContentUnavailableView(
//                "Aucun objectif",
//                systemImage: <#T##String#>,
//                description: <#T##Text?#>
//            )
//        }
        .navigationTitle("Objectifs")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    IconView(icon: .iconProfile)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    FinancialGoalListScreen()
}

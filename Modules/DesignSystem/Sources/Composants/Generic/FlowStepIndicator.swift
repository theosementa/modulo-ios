//
//  FlowStepIndicator.swift
//  DesignSystem
//
//  Created by Theo Sementa on 06/06/2026.
//

import SwiftUI

public struct FlowStepIndicator: View {

    // MARK: Dependencies
    private let currentStep: Int
    private let totalSteps: Int

    // MARK: Environment
    @Environment(\.theme) private var theme

    // MARK: Init
    public init(currentStep: Int, totalSteps: Int) {
        self.currentStep = currentStep
        self.totalSteps = totalSteps
    }

    // MARK: - View
    public var body: some View {
        HStack(spacing: .medium) {
            ForEach(1...max(1, totalSteps), id: \.self) { step in
                Capsule()
                    .fill(step <= currentStep ? theme.color : Color.Background.bg200)
                    .frame(height: 4)
                    .animation(.easeInOut, value: currentStep)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Step \(currentStep) of \(totalSteps)")
        .accessibilityValue("\(Int((Double(currentStep) / Double(max(1, totalSteps))) * 100)) percent complete")
    }
}

// MARK: - Preview
#Preview("Step 1 of 3") {
    FlowStepIndicator(currentStep: 1, totalSteps: 3)
        .padding(.standard)
}

#Preview("Step 2 of 3") {
    FlowStepIndicator(currentStep: 2, totalSteps: 3)
        .padding(.standard)
}

#Preview("Step 3 of 3") {
    FlowStepIndicator(currentStep: 3, totalSteps: 3)
        .padding(.standard)
}

#Preview("All steps animated") {
    VStack(spacing: .standard) {
        FlowStepIndicator(currentStep: 1, totalSteps: 3)
        FlowStepIndicator(currentStep: 2, totalSteps: 3)
        FlowStepIndicator(currentStep: 3, totalSteps: 3)
    }
    .padding(.standard)
}

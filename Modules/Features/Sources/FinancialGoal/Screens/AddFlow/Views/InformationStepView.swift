//
//  InformationStepView.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import SwiftUI
import DesignSystem
import Core
import MCEmojiPicker

struct InformationStepView: View {

    // MARK: Dependencies
    @Bindable var store: DefaultAddFinancialGoalFlowStore

    // MARK: - View
    var body: some View {
        VStack(spacing: .zero) {
            formContentView

            Spacer()

            ActionButtonView(text: "add_flow_step_info_next_button".localized) {
                store.send(.nextTapped)
            }
            .disabled(!store.state.canSubmit)
        }
        .padding(.large)
    }
}

// MARK: - Subviews
private extension InformationStepView {

    var formContentView: some View {
        VStack(spacing: .huge) {
            VStack(spacing: .standard) {
                emojiPickerView
                
                nameFieldView
            }

            datesView
        }
    }

    var emojiPickerView: some View {
        Button { store.send(.toggleEmojiPicker) } label: {
            Text(store.state.emoji)
                .font(.Title.mediumMedium)
                .frame(width: 56, height: 56)
                .background(Color.Base.white, in: .rect(cornerRadius: .standard, style: .continuous))
        }
        .emojiPicker(
            isPresented: .init(
                get: { store.state.showEmojiPicker },
                set: { _ in store.send(.toggleEmojiPicker) }
            ),
            selectedEmoji: .init(
                get: { store.state.emoji },
                set: { store.send(.emojiChanged($0)) }
            )
        )
    }

    var nameFieldView: some View {
        VStack(spacing: .small) {
            Text("add_goal_field_name_title".localized)
                .font(.Label.largeMedium, color: .Text.secondary)

            TextField(
                "add_flow_step_info_name_placeholder".localized,
                text: .init(
                    get: { store.state.name },
                    set: { store.send(.nameChanged($0)) }
                )
            )
            .font(.Body.largeSemiBold, color: .Text.primary)
            .multilineTextAlignment(.center)
        }
    }

    var datesView: some View {
        VStack(spacing: .medium) {
            dateRowView(
                caption: "generic_start_date".localized,
                date: .init(
                    get: { store.state.startDate },
                    set: { if let d = $0 { store.send(.startDateChanged(d)) } }
                )
            )

            dateRowView(
                caption: "generic_end_date".localized,
                date: .init(
                    get: { store.state.endDate },
                    set: { if let d = $0 { store.send(.endDateChanged(d)) } }
                )
            )
        }
    }

    func dateRowView(caption: String, date: Binding<Date?>) -> some View {
        VStack(alignment: .leading, spacing: .small) {
            Text(caption)
                .font(.Label.largeMedium, color: .Text.secondary)
            DatePickerView(date: date)
        }
    }

}

// MARK: - Preview
#Preview {
    @Previewable @State var store = DefaultAddFinancialGoalFlowStore()
    InformationStepView(store: store)
        .background(Color.Background.bg50)
}

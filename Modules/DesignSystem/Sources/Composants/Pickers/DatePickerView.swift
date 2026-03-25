//
//  DatePickerView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 25/03/2026.
//

import SwiftUI

public struct DatePickerView: View {

    // MARK: Dependencies
    @Binding var date: Date?
    private let placeholder: String?

    // MARK: States
    @State private var showCalendar: Bool = false

    // MARK: Init
    public init(
        date: Binding<Date?>,
        placeholder: String? = nil
    ) {
        self._date = date
        self.placeholder = placeholder
    }

    // MARK: - Computed
    private var dateBinding: Binding<Date> {
        Binding(
            get: { date ?? .now },
            set: { date = $0 }
        )
    }

    private var displayText: String {
        if let date {
            return date.formatted(.dateTime.day().month(.abbreviated).year())
        }
        return placeholder ?? ""
    }

    // MARK: - View
    public var body: some View {
        SmallActionButtonView(
            style: date == nil ? .noValue : .classic,
            icon: .iconCalendar,
            text: displayText,
            config: .init(isFullWidth: true)
        ) {
            showCalendar.toggle()
        }
        .popover(isPresented: $showCalendar) {
            DatePicker(
                "Select date",
                selection: dateBinding,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .padding()
            .frame(width: 365, height: 365) // Support iPhone SE
            .presentationCompactAdaptation(.popover) // show popOver on iPhones
        }
        .onChange(of: date) {
            showCalendar = false
        }
    }
}

// MARK: - Preview
#Preview {
    @Previewable @State var date: Date? = nil
    DatePickerView(date: $date)
}

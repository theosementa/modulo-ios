//
//  ContributionLineChartView.swift
//  Features
//
//  Created by Theo Sementa on 26/03/2026.
//

import SwiftUI
import Charts
import Models
import DesignSystem

struct ContributionLineChartView: View {

    // MARK: Dependencies
    let dataPoints: [ContributionMonthlyDataPoint]
    
    // MARK: Environment
    @Environment(\.theme) private var theme

    // MARK: States
    @State private var currentPage: Int = 0
    @State private var selectedMonth: Date?

    // MARK: Constants
    private let pageSize = 6

    // MARK: Computed
    private var totalPages: Int {
        guard !dataPoints.isEmpty else { return 1 }
        return Int(ceil(Double(dataPoints.count) / Double(pageSize)))
    }

    private var visiblePoints: [ContributionMonthlyDataPoint] {
        guard !dataPoints.isEmpty else { return [] }
        let endIndex = dataPoints.count - currentPage * pageSize
        let startIndex = max(0, endIndex - pageSize)
        guard startIndex < endIndex else { return [] }
        return Array(dataPoints[startIndex..<endIndex])
    }

    private var selectedPoint: ContributionMonthlyDataPoint? {
        guard let selectedMonth else { return nil }
        return visiblePoints.min(by: {
            abs($0.month.timeIntervalSince(selectedMonth)) < abs($1.month.timeIntervalSince(selectedMonth))
        })
    }

    private var canGoBack: Bool { currentPage < totalPages - 1 }
    private var canGoForward: Bool { currentPage > 0 }

    private var rangeLabel: String {
        guard let first = visiblePoints.first, let last = visiblePoints.last else { return "" }
        guard first.id != last.id else { return first.monthLabel }
        return "\(first.monthLabel) – \(last.monthLabel)"
    }

    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: .standard) {
            chartView
                .animation(.easeInOut(duration: 0.3), value: currentPage)

            navigationView
        }
        .padding(.standard)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .mediumLarge, style: .continuous))
    }
}

// MARK: - Subviews
private extension ContributionLineChartView {

    var chartView: some View { // TODO: TBL
        Chart(visiblePoints) { point in
            let isSelected = selectedPoint?.id == point.id

            LineMark(
                x: .value("Mois", point.month, unit: .month),
                y: .value("Montant", point.netAmount)
            )
            .foregroundStyle(theme.color)
            .interpolationMethod(.catmullRom)

            AreaMark(
                x: .value("Mois", point.month, unit: .month),
                y: .value("Montant", point.netAmount)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [theme.color.opacity(0.25), .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .interpolationMethod(.catmullRom)

            PointMark(
                x: .value("Mois", point.month, unit: .month),
                y: .value("Montant", point.netAmount)
            )
            .foregroundStyle(isSelected ? Color.white : theme.color)
            .symbolSize(isSelected ? 80 : 40)
            .annotation(position: .top, spacing: 6) {
                if isSelected {
                    selectionCalloutView(point)
                }
            }

            if visiblePoints.contains(where: { $0.netAmount < 0 }) {
                RuleMark(y: .value("Zéro", 0))
                    .foregroundStyle(theme.color.opacity(0.4))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
            }

            // Ligne verticale sur le point sélectionné
            if let selected = selectedPoint, isSelected {
                RuleMark(x: .value("Sélectionné", selected.month, unit: .month))
                    .foregroundStyle(Color.secondary.opacity(0.25))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
            }
        }
        .chartXSelection(value: $selectedMonth)
        .chartXAxis {
            AxisMarks(values: visiblePoints.map(\.month)) { value in
                AxisGridLine()
                AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let amount = value.as(Double.self) {
                        Text(Int(amount).toCurrency())
                            .font(.caption2)
                    }
                }
            }
        }
        .frame(height: 300)
        .onChange(of: currentPage) { selectedMonth = nil }
    }

    func selectionCalloutView(_ point: ContributionMonthlyDataPoint) -> some View {
        let isPositive = point.netAmount >= 0
        let amountText = isPositive
            ? "+\(Int(point.netAmount).toCurrency())"
            : "\(Int(point.netAmount).toCurrency())"

        return VStack(spacing: 2) {
            Text(point.monthLabel)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(amountText)
                .font(.caption.bold())
                .foregroundStyle(isPositive ? .green : .red)
        }
        .padding(.horizontal, .small)
        .padding(.vertical, 5)
        .background(Color.Background.bg100, in: .rect(cornerRadius: .small, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }

    var navigationView: some View {
        HStack(spacing: .small) {
            IconButtonView(.iconChevronLeft, config: .init(bgColor: .Background.bg200)) {
                withAnimation { currentPage += 1 }
            }
            .opacity(canGoBack ? 1 : 0.2)
            .disabled(!canGoBack)

            Text(rangeLabel)
                .font(.Body.mediumMedium)
                .fullWidth()
            
            IconButtonView(.iconChevronRight, config: .init(bgColor: .Background.bg200)) {
                withAnimation { currentPage -= 1 }
            }
            .opacity(canGoForward ? 1 : 0.2)
            .disabled(!canGoForward)
        }
    }
}

// MARK: - Preview
#Preview {
    ContributionLineChartView(
        dataPoints: FinancialGoalDetailedDomain.mock.toUIModel().contributionsByMonth
    )
    .padding()
}

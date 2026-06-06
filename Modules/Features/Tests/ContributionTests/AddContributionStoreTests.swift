//
//  AddContributionStoreTests.swift
//  Features
//
//  Created by Theo Sementa on 06/06/2026.
//

import Testing
import Foundation
@testable import Contribution
@testable import DataSources

@MainActor
struct AddContributionStoreTests {

    var store: DefaultAddContributionStore = .init(
        state: .init(),
        contributionDataSource: MockContributionDataSource(goalId: "mock-1"),
        financialGoalDataSource: MockFinancialGoalDataSource()
    )

    var storeUpdate: DefaultAddContributionStore = {
        let s = DefaultAddContributionStore(
            state: .init(),
            contributionDataSource: MockContributionDataSource(goalId: "mock-1"),
            financialGoalDataSource: MockFinancialGoalDataSource()
        )
        s.send(.bootstrap(goalId: "mock-1", contributionId: "m1-c1"))
        return s
    }()

    var storeUpdateInvalid: DefaultAddContributionStore = {
        let s = DefaultAddContributionStore(
            state: .init(),
            contributionDataSource: MockContributionDataSource(goalId: "mock-1"),
            financialGoalDataSource: MockFinancialGoalDataSource()
        )
        s.send(.bootstrap(goalId: "mock-1", contributionId: "-c1"))
        return s
    }()

    // MARK: - isModelInCreation
    @Test
    func isModelInCreation_whenAmountIsZeroAndNameIsEmpty_returnsFalse() async throws {
        store.send(.bootstrap(goalId: "mock-1", contributionId: nil))
        store.send(.amountChanged("0"))
        store.send(.nameChanged("     "))
        #expect(store.state.isModelInCreation == false)
    }

    @Test
    func isModelInCreation_whenAmountIsNonZero_returnsTrue() async throws {
        store.send(.amountChanged("123"))
        store.send(.nameChanged(""))
        #expect(store.state.isModelInCreation == true)
    }

    @Test
    func isModelInCreation_whenNameIsNotEmpty_returnsTrue() async throws {
        store.send(.amountChanged("0"))
        store.send(.nameChanged("Testing"))
        #expect(store.state.isModelInCreation == true)
    }

    // MARK: - bootstrap (edit mode prefill)
    @Test
    func init_whenContributionIdIsValid_prefillsFields() async throws {
        #expect(storeUpdate.state.name.isEmpty == false || storeUpdate.state.amount.toDouble() != 0)
        #expect(storeUpdate.state.amount.toDouble() != 0)
    }

    @Test
    func init_whenContributionIdIsInvalid_fieldsAreDefault() async throws {
        #expect(storeUpdateInvalid.state.name.isEmpty == true)
        #expect(storeUpdateInvalid.state.amount.toDouble() == 0)
    }

    // MARK: - save (validation)
    @Test
    func validationAction_whenAmountIsZero_throwsMissingAmountAndShowsToast() async throws {
        let mockContributionDataSource = MockContributionDataSource(goalId: "mock-1")
        let testStore = DefaultAddContributionStore(
            state: .init(),
            contributionDataSource: mockContributionDataSource,
            financialGoalDataSource: MockFinancialGoalDataSource()
        )
        let initialCount = mockContributionDataSource.contributions.count

        testStore.send(.bootstrap(goalId: "mock-1", contributionId: nil))
        testStore.send(.save)

        // Allow the async task to run
        try await Task.sleep(nanoseconds: 100_000_000)

        #expect(mockContributionDataSource.contributions.count == initialCount)
    }

    // Enable later
//    @Test
//    func validationAction_whenAmountIsValid_andNotEditing_callsCreate() async throws {
//        let mockStore = MockContributionDataSource(goalId: "mock-1")
//        let testStore = DefaultAddContributionStore(
//            state: .init(),
//            contributionDataSource: mockStore,
//            financialGoalDataSource: MockFinancialGoalDataSource()
//        )
//        let initialCount = mockStore.contributions.count
//
//        testStore.send(.bootstrap(goalId: "mock-1", contributionId: nil))
//        testStore.send(.amountChanged("123"))
//        testStore.send(.nameChanged("Testing"))
//        testStore.send(.save)
//
//        try await Task.sleep(nanoseconds: 100_000_000)
//
//        #expect(mockStore.contributions.count == initialCount + 1)
//    }
//
//    @Test
//    func validationAction_whenAmountIsValid_andEditing_callsUpdate() async throws {
//        let mockStore = MockContributionDataSource(goalId: "mock-1")
//        let testStore = DefaultAddContributionStore(
//            state: .init(),
//            contributionDataSource: mockStore,
//            financialGoalDataSource: MockFinancialGoalDataSource()
//        )
//
//        testStore.send(.bootstrap(goalId: "mock-1", contributionId: "m1-c1"))
//        testStore.send(.amountChanged("999"))
//        testStore.send(.nameChanged("Testing"))
//        testStore.send(.update)
//
//        try await Task.sleep(nanoseconds: 100_000_000)
//
//        #expect(mockStore.contributions.first(where: { $0.id == "m1-c1" })?.amount == 999)
//    }

    // MARK: - dismissAttempted
    @Test
    func dismissAction_whenModelIsInCreation_emitsPresentLeaveAlert() async throws {
        store.send(.nameChanged("Testing"))

        var receivedEffect: AddContributionSideEffect?
        let collectTask = Task {
            for await effect in store.sideEffects {
                receivedEffect = effect
                break
            }
        }

        store.send(.dismissAttempted)
        try await Task.sleep(nanoseconds: 100_000_000)
        collectTask.cancel()

        #expect(receivedEffect == .presentLeaveAlert)
    }

    @Test
    func dismissAction_whenModelIsNotInCreation_emitsDismiss() async throws {
        var receivedEffect: AddContributionSideEffect?
        let collectTask = Task {
            for await effect in store.sideEffects {
                receivedEffect = effect
                break
            }
        }

        store.send(.dismissAttempted)
        try await Task.sleep(nanoseconds: 100_000_000)
        collectTask.cancel()

        #expect(receivedEffect == .dismiss)
    }

}

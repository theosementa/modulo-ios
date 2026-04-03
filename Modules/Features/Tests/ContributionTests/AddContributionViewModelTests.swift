//
//  AddContributionViewModelTests.swift
//  Features
//
//  Created by Theo Sementa on 03/04/2026.
//

import Testing
import Foundation
@testable import Contribution
@testable import Stores

@MainActor
struct AddContributionViewModelTests {
    
    var viewModel: AddContributionScreen.ViewModel = .init(
        goalId: "mock-1",
        contributionStore: MockContributionStore(goalId: "mock-1"),
        financialGoalStore: MockFinancialGoalStore()
    )
    
    var viewModelUpdate: AddContributionScreen.ViewModel = .init(
        goalId: "mock-1",
        contributionId: "m1-c1",
        contributionStore: MockContributionStore(goalId: "mock-1"),
        financialGoalStore: MockFinancialGoalStore()
    )
    
    var viewModelUpdateInvalid: AddContributionScreen.ViewModel = .init(
        goalId: "mock-1",
        contributionId: "-c1",
        contributionStore: MockContributionStore(goalId: "mock-1"),
        financialGoalStore: MockFinancialGoalStore()
    )


    // MARK: - isModelInCreation
    @Test
    func isModelInCreation_whenAmountIsZeroAndNameIsEmpty_returnsFalse() async throws {
        viewModel.amount = "0"
        viewModel.name = "     "
        #expect(viewModel.isModelInCreation == false)
    }

    @Test
    func isModelInCreation_whenAmountIsNonZero_returnsTrue() async throws {
        viewModel.amount = "123"
        viewModel.name = ""
        #expect(viewModel.isModelInCreation == true)
    }

    @Test
    func isModelInCreation_whenNameIsNotEmpty_returnsTrue() async throws {
        viewModel.amount = "0"
        viewModel.name = "Testing"
        #expect(viewModel.isModelInCreation == true)
    }

    // MARK: - init (edit mode prefill)
    @Test
    func init_whenContributionIdIsValid_prefillsFields() async throws {
        #expect(viewModelUpdate.name.isEmpty == false)
        #expect(viewModelUpdate.amount.toDouble() != 0)
    }

    @Test
    func init_whenContributionIdIsInvalid_fieldsAreDefault() async throws {
        #expect(viewModelUpdateInvalid.name.isEmpty == true)
        #expect(viewModelUpdateInvalid.amount.toDouble() == 0)
    }

    // MARK: - validationAction
    @Test
    func validationAction_whenAmountIsZero_throwsMissingAmountAndShowsToast() async throws {
        viewModel.amount = "0"
        await viewModel.validationAction()
        #expect(viewModel.toastBannerService.toastBanner == .errorAmountMandatory)
    }

    @Test
    func validationAction_whenAmountIsValid_andNotEditing_callsCreate() async throws {
        viewModel.amount = "123"
        viewModel.name = "Testing"
        await viewModel.validationAction()
        #expect(viewModel.toastBannerService.toastBanner == .successGoalCreated)
    }

    @Test
    func validationAction_whenAmountIsValid_andEditing_callsUpdate() async throws {
        viewModelUpdate.amount = "123"
        viewModelUpdate.name = "Testing"
        await viewModelUpdate.validationAction()
        #expect(viewModelUpdate.toastBannerService.toastBanner == .successGoalUpdated)
    }

    // MARK: - dismissAction
    @Test
    func dismissAction_whenModelIsInCreation_presentsAlert() async throws {
        viewModel.name = "Testing"
        viewModel.dismissAction()
        #expect(viewModel.isAlertLeavePresented == true)
    }

    @Test
    func dismissAction_whenModelIsNotInCreation_dismisses() async throws {
        viewModel.dismissAction()
        #expect(viewModel.isAlertLeavePresented == false)
    }

}

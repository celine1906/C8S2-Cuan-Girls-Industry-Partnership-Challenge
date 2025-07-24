//
//  InputSimulationViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 23/07/25.
//

import Foundation
import SwiftUI
import Combine

enum LoanStatus {
    case green
    case yellow
    case red
}


final class InputSimulationViewModel: ObservableObject {
    @Published var loanAmount: Double
    @Published var userAvgIncome: Int
    @Published var selectedPlatform = Platform(name: "EasyCash", interestRange: "0.03% - 0.3%", maxInterest: 0.3)
    @Published var selectedTenor: Int = 180 // in days
    @Published var monthlyInstallment: String = ""
    @Published var totalLoans: Int = 0
    @Published var safeLoanAmount: Double = 0.0
    @Published var maxSafeLoanAmount: Double = 0.0
    @Published var availablePlatforms: [Platform] = []
    @Published var loanStatus: LoanStatus = .green
    
    @Published var riskThreshold1 = 0.0
    @Published var riskThreshold2 = 0.0

    private var userRestIncome: Int
    private var cancellables = Set<AnyCancellable>()

    init(userFinancial: UserFinancial, userWants: UserWants) {
        self.userRestIncome = userFinancial.avgIncome - userFinancial.avgExpense - userFinancial.installmentAmount
        self.loanAmount = Double(userWants.itemPrice)
        self.userAvgIncome = userFinancial.avgIncome

        self.availablePlatforms = [
            Platform(name: "EasyCash", interestRange: "0.03% - 0.3%", maxInterest: 0.3),
            Platform(name: "AkuLaku", interestRange: "0.1% - 0.3%", maxInterest: 0.3),
            Platform(name: "AdaPundi", interestRange: "0.15% - 0.3%", maxInterest: 0.3),
            Platform(name: "Indosaku", interestRange: "0.02% - 0.3%", maxInterest: 0.3),
            Platform(name: "Kredivo", interestRange: "0.05% - 0.3%", maxInterest: 0.3)
        ]

        setupBindings()
        setupMaxInstallmentBinding()
    }

    private func setupBindings() {
        Publishers.CombineLatest3($loanAmount, $selectedTenor, $selectedPlatform)
            .sink { [weak self] (amount, tenor, platform) in
                self?.calculateInstallment(amount: Int(amount), tenor: tenor, interest: platform.maxInterest)
            }
            .store(in: &cancellables)
    }

    private func setupMaxInstallmentBinding() {
        Publishers.CombineLatest($selectedTenor, $selectedPlatform)
            .sink { [weak self] tenor, platform in
                self?.calculateLoansAndThresholds(tenor: tenor, interest: platform.maxInterest)
                
            }
            .store(in: &cancellables)
    }

    private func calculateLoansAndThresholds(tenor: Int, interest: Double) {
        let totalInterest = interest * Double(tenor)
        let maxLoan = (Double(userAvgIncome) * 0.3) / (1 + (totalInterest / 100))
        let safeLoan = maxLoan * (Double(tenor) / 30)
        self.safeLoanAmount = safeLoan

        let maxSafeLoan = (Double(userAvgIncome) / (1 + (totalInterest / 100))) * (Double(tenor) / 30)
        self.maxSafeLoanAmount = maxSafeLoan

        recalculateThresholds()
    }
    
    private func recalculateThresholds() {
        let lowerBound = 500_000.0
        let upperBound = 100_000_000.0
        let totalRange = upperBound - lowerBound
        
        self.riskThreshold1 = (safeLoanAmount - lowerBound) / totalRange
        self.riskThreshold2 = (maxSafeLoanAmount - lowerBound) / totalRange
    }


    private func calculateInstallment(amount: Int, tenor: Int, interest: Double) {
        let totalInterest = Double(amount) * (interest / 100) * Double(tenor)
        let total = Double(amount) + totalInterest
        let monthly = total / (Double(tenor) / 30)

        self.monthlyInstallment = formatToCurrency(monthly)
        self.totalLoans = Int(total)

        let monthlyInt = Int(monthly)
        let greenLimit = Int(Double(userAvgIncome) * 0.3)

        if monthlyInt <= greenLimit {
            loanStatus = .green
        } else if monthlyInt <= userRestIncome {
            loanStatus = .yellow
        } else {
            loanStatus = .red
        }
    }

    private func formatToCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp"
        formatter.locale = Locale(identifier: "id_ID")
        return formatter.string(from: NSNumber(value: amount)) ?? "Rp0"
    }
}

//
//  SimulasiPinjamanViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 25/07/25.
//

import Foundation

class SimulasiPinjamanViewModel: ObservableObject {
    @Published var isNavigating: Bool = false
    
    let loanCalculation:LoanCalculationResult
    
    init(loanCalculation:LoanCalculationResult) {
        self.loanCalculation = loanCalculation
    }
    
    func getLateInterest(month: Int) -> Double {
        let lateInterest = loanCalculation.dailyInterestRate * 30 * Double(month)
        let totalLateInterest = lateInterest + loanCalculation.totalInterest
        return totalLateInterest
    }
    
    func getPenaltyInterest(month: Int) -> Double {
        let penaltyInterest = 0.001 * 30 * Double(month) * loanCalculation.loanAmount
        return penaltyInterest
    }
    
    
    func getTotalRepayment(month: Int) -> Double {
        let totalRepayment = getLateInterest(month: month) + getPenaltyInterest(month: month) + loanCalculation.loanAmount
        return totalRepayment
    }
    
}

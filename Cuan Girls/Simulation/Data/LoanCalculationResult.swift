//
//  LoanCalculationResult.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 25/07/25.
//

import Foundation

struct LoanCalculationResult {
    let loanAmount: Double
    let dailyInterestRate: Double
    let interestPerDay: Double
    let tenorInDays: Int
    let totalInterest: Double
    let totalRepayment: Double
    let monthlyInstallment: Double
}

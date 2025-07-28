//
//  InputTrackerViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 22/07/25.
//

import Foundation
import Combine

class InputTrackerViewModel: ObservableObject {
    @Published var isNavigating: Bool = false
    
    @Published var avgIncome: String = ""
    @Published var lowestIncome: String = ""
    @Published var avgExpense: String = ""
    @Published var hasInstallment: Bool? = nil
    @Published var installmentAmount: String = ""
    @Published var isIncomeFluctuating: Bool
    @Published var savedUserFinancial: UserFinancial?

    let userWants: UserWants

    init(userWants: UserWants) {
        self.userWants = userWants
        self.isIncomeFluctuating = userWants.isIncomeFluctuating
    }

    var isFormValid: Bool {
        guard !avgIncome.trimmingCharacters(in: .whitespaces).isEmpty,
              !avgExpense.trimmingCharacters(in: .whitespaces).isEmpty,
                hasInstallment != nil
        else {
            return false
        }
        
        // Jika pendapatan fluktuatif, lowestIncome wajib diisi
        if isIncomeFluctuating && lowestIncome.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        // Jika punya cicilan, installmentAmount wajib diisi
        if let hasInstallment = hasInstallment {
            if hasInstallment && installmentAmount.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
        }
        
        
        return true
    }

    func save() {
        guard let hasInstallment = hasInstallment else { return }

        savedUserFinancial = UserFinancial(
            id: 1,
            avgIncome: avgIncome.toInt(),
            lowestIncome: isIncomeFluctuating ? lowestIncome.toIntOrNil() : nil,
            avgExpense: avgExpense.toInt(),
            hasInstallment: hasInstallment,
            installmentAmount: hasInstallment ? installmentAmount.toInt() : 0
        )
    }
}



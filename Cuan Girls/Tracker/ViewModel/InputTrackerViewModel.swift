//
//  InputTrackerViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 22/07/25.
//

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
              !avgExpense.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        if isIncomeFluctuating == true {
            return !lowestIncome.trimmingCharacters(in: .whitespaces).isEmpty
        }
        if hasInstallment == true {
            return !installmentAmount.trimmingCharacters(in: .whitespaces).isEmpty
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
            installmentAmount: hasInstallment ? installmentAmount.toIntOrNil() : nil
        )
    }

    func formatCurrency(_ value: inout String) {
        let raw = value.replacingOccurrences(of: ".", with: "")
        if let doubleVal = Double(raw) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            formatter.maximumFractionDigits = 0
            value = formatter.string(from: NSNumber(value: doubleVal)) ?? ""
        }
    }
}

private extension String {
    func toInt() -> Int {
        return Int(self.replacingOccurrences(of: ".", with: "")) ?? 0
    }

    func toIntOrNil() -> Int? {
        let cleaned = self.replacingOccurrences(of: ".", with: "")
        return Int(cleaned)
    }
}

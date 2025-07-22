//
//  UserWantsViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 22/07/25.
//

import Foundation
import Combine

class UserWantsViewModel: ObservableObject {
    @Published var isNavigating: Bool = false
    @Published var itemName: String = ""
    @Published var rawItemPriceText: String = "" {
        didSet {
            let raw = rawItemPriceText.replacingOccurrences(of: ".", with: "")
            if let doubleValue = Double(raw) {
                itemPrice = doubleValue
            } else {
                itemPrice = 0
            }
        }
    }
    
    @Published var itemPrice: Double = 0
    @Published var isIncomeFluctuating: Bool? = nil
    
    // Buat fungsi format manual
    func formatPriceText() {
        if itemPrice > 0 {
            rawItemPriceText = rupiahFormatter.string(from: NSNumber(value: itemPrice)) ?? rawItemPriceText
        }
    }
    
    var isPriceTooHigh: Bool {
        itemPrice > 100_000_000
    }

    var isFormValid: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty &&
        itemPrice > 0 &&
        !isPriceTooHigh &&
        isIncomeFluctuating != nil
    }

    @Published var savedUserWants: UserWants?

    func save() {
        if isFormValid {
            savedUserWants = userWants
        }
    }

    var userWants: UserWants? {
        if let isFluctuating = isIncomeFluctuating {
            return UserWants(
                id: 1,
                itemName: itemName,
                itemPrice: Int(itemPrice),
                isIncomeFluctuating: isFluctuating
            )
        }
        return nil
    }

    let rupiahFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        formatter.positivePrefix = "Rp "
        return formatter
    }()
}

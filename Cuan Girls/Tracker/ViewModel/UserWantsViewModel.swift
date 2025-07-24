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
    @Published var rawItemPriceText: String = ""
    @Published var itemPrice: Double = 0
    @Published var isIncomeFluctuating: Bool? = nil
    
    var isPriceTooHigh: Bool {
        rawItemPriceText.toInt() > 100_000_000
    }
    
    var isPriceTooLow: Bool {
        rawItemPriceText.toInt() < 500_000
    }

    var isFormValid: Bool {
        !itemName.trimmingCharacters(in: .whitespaces).isEmpty &&
        rawItemPriceText.toInt() > 0 &&
        !isPriceTooHigh && !isPriceTooLow &&
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
                itemPrice: rawItemPriceText.toInt(),
                isIncomeFluctuating: isFluctuating
            )
        }
        return nil
    }
}

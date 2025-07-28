//
//  UserFinancial.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 22/07/25.
//

import Foundation

struct UserFinancial: Identifiable {
    var id: Int
    var avgIncome: Int
    var lowestIncome: Int?
    var avgExpense: Int
    var hasInstallment: Bool
    var installmentAmount: Int
}

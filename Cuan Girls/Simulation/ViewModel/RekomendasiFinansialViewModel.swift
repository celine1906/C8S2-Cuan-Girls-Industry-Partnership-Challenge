//
//  RekomendasiFinansialViewModel.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 23/07/25.
//

import Foundation

class RekomendasiFinansialViewModel: ObservableObject {
    let userFinancial: UserFinancial

    init(userFinancial: UserFinancial) {
        self.userFinancial = userFinancial
    }

    var pendapatan: CGFloat {
        CGFloat(userFinancial.avgIncome)
    }

    var pengeluaran: CGFloat {
        CGFloat(userFinancial.avgExpense)
    }

    var cicilan: CGFloat {
        CGFloat(userFinancial.installmentAmount)
    }

    var sisa: CGFloat {
        pendapatan - pengeluaran - cicilan
    }

    var persenSisa: CGFloat {
        pendapatan == 0 ? 0 : (sisa / pendapatan) * 100
    }

    var pengeluaranRatio: CGFloat {
        pendapatan == 0 ? 0 : pengeluaran / pendapatan
    }

    var cicilanRatio: CGFloat {
        pendapatan == 0 ? 0 : cicilan / pendapatan
    }

    var status: FinancialStatus {
        if persenSisa <= 0 {
            return .tidakDisarankan
        } else if persenSisa < 30 {
            return .pengeluaranTinggi
        } else {
            return .sehat
        }
    }

    func formatToCurrency(_ value: CGFloat) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: Double(value))) ?? "0"
    }
}


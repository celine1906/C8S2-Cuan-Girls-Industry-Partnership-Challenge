//
//  FinancialStatus.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 23/07/25.
//

import Foundation
import SwiftUI

enum FinancialStatus {
    case tidakDisarankan
    case pengeluaranTinggi
    case sehat

    var title: String {
        switch self {
        case .tidakDisarankan:
            return "Kamu tidak disarankan untuk melakukan peminjaman"
        case .pengeluaranTinggi:
            return "Pengeluaran kamu cukup tinggi nih"
        case .sehat:
            return "Pertahankan rasio pengeluaranmu"
        }
    }

    var message: String {
        switch self {
        case .tidakDisarankan:
            return "Ayo **tabung 30% dari pendapatanmu** setiap bulannya agar keuanganmu lebih sehat"
        case .pengeluaranTinggi:
            return "Coba **sisihkan minimal 30% dari pendapatanmu** untuk ditabung ya!\nTapi tenang, kamu tetap bisa lanjut simulasi kok"
        case .sehat:
            return "agar tidak melebihi 30% dari pendapatanmu"
        }
    }

    var buttonText: String {
        switch self {
        case .tidakDisarankan:
            return "Selesai"
        default:
            return "Mulai Simulasi"
        }
    }

    var color: Color {
        switch self {
        case .tidakDisarankan, .pengeluaranTinggi:
            return .red
        case .sehat:
            return .green
        }
    }
}

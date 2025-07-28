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
            return "Yah, sisa uangmu terlalu rendah"
        case .pengeluaranTinggi:
            return "Pengeluaran kamu cukup tinggi nih"
        case .sehat:
            return "Pertahankan rasio pengeluaranmu"
        }
    }

    var message: Text {
        switch self {
        case .tidakDisarankan:
            return Text("Limit minimum pinjaman di P2P lending adalah Rp 500.000. Coba **sisihkan minimal 30% dari pendapatanmu** untuk ditabung ya!")
        case .pengeluaranTinggi:
            return Text("Coba **sisihkan minimal 30% dari pendapatanmu** untuk ditabung ya! Tenang, kamu tetap bisa lanjut simulasi kok")
        case .sehat:
            return Text("Dengan sisa uang lebih dari 30%, kamu sudah bisa melakukan pinjaman.")
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
            return .sisa
        case .sehat:
            return .sisaAman
        }
    }
    
    var image: String {
        switch self {
        case .tidakDisarankan:
            return "output3"
        case .pengeluaranTinggi:
            return "output2"
        case .sehat:
            return "output1"
        }
    }
}

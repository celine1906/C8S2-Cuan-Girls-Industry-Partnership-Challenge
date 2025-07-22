// buat ubah penulisan format nominal dari 1500000 jadi 1.500.000

import Foundation

extension NumberFormatter {
    static let rupiah: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        return formatter
    }()
}

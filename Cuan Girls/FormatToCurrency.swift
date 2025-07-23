import Foundation

func formatToCurrency(_ value: CGFloat) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}

func formatCurrency(_ value: inout String) {
    // Hapus Rp, spasi, dan titik
    let raw = value
        .replacingOccurrences(of: "Rp", with: "")
        .replacingOccurrences(of: " ", with: "")
        .replacingOccurrences(of: ".", with: "")

    if let doubleVal = Double(raw) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
        formatter.positivePrefix = "Rp "
        value = formatter.string(from: NSNumber(value: doubleVal)) ?? ""
    }
}

extension String {
    func toInt() -> Int {
        return Int(
            self.replacingOccurrences(of: "Rp ", with: "")
            .replacingOccurrences(of: ".", with: "")
        ) ?? 0
    }

    func toIntOrNil() -> Int? {
        let cleaned = self
            .replacingOccurrences(of: "Rp ", with: "")
            .replacingOccurrences(of: ".", with: "")
        return Int(cleaned)
    }
}

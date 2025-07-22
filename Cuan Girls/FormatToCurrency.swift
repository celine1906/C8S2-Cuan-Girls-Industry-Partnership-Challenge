import Foundation

func formatToCurrency(_ value: CGFloat) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = "."
    return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
}

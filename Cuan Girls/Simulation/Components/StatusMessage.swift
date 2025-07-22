// status message cicilan aman atau beresiko

import SwiftUI

struct StatusMessage: View {
    let title: String // Cicilan Bulanan
    let amount: String // Nominal
    let message: String // Messagenya
    let isPositive: Bool // Buat colornya

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isPositive ? .green : .red)
                Spacer()
                Text(amount)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isPositive ? .green : .red)
            }
            
            Divider()
                .background(isPositive ? .green : .red)
            
            Text(message)
                .font(.caption)
                .foregroundColor(isPositive ? .green : .red)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(isPositive ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isPositive ? Color.green : Color.red, lineWidth: 1)
                )
        )
    }
}

struct StatusMessage_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            StatusMessage(
                title: "Cicilan Bulanan",
                amount: "Rp 1.540.000",
                message: "Cicilan sudah di bawah 30% pendapatanmu.",
                isPositive: true
            )
            .padding(.horizontal)

            StatusMessage(
                title: "Cicilan Bulanan",
                amount: "Rp 8.380.000",
                message: "Cicilan sudah di atas 30% pendapatanmu.",
                isPositive: false
            )
            .padding(.horizontal)
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

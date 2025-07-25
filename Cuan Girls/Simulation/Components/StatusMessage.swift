// status message cicilan aman atau beresiko

import SwiftUI

struct StatusMessage: View {
    let title: String // Cicilan Bulanan
    let amount: String // Nominal
    let message: String // Messagenya
    let color: Color // Buat colornya
    let income: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Text("Rp \(amount)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color) 
            }
            
            HStack {
                Text("Sisa Uang")
                    .font(.subheadline)
                Spacer()
                Text("Rp \(income)")
                    .font(.subheadline)
            }
            
            Divider()
                .background(color)
            
            Text(message)
                .font(.caption)
                .foregroundColor(color)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(color).opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(color, lineWidth: 1)
                )
        )
    }
}

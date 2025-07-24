// status message cicilan aman atau beresiko

import SwiftUI

struct StatusMessage: View {
    let title: String // Cicilan Bulanan
    let amount: String // Nominal
    let message: String // Messagenya
    let color: Color // Buat colornya
    
    @ObservedObject var viewModel: InputSimulationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(color)
                Spacer()
                Text(amount)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
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

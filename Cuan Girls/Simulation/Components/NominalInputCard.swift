// Card Nominal Input + Slider di Input Simulasi

import SwiftUI

struct NominalInputCard: View {
    @Binding var value: Double
    @StateObject var viewModel: InputSimulationViewModel

    @State private var isEditing: Bool = false
    @State private var inputText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nominal Pinjaman")
                .font(.subheadline)
                .bold()

            HStack {
                if isEditing {
                    TextField("Masukkan nominal", text: $inputText)
                        .keyboardType(.numberPad)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onChange(of: inputText) {
                            formatCurrency(&inputText)
                        }
                        .onAppear {
                            inputText = formatToCurrency(CGFloat(value))
                        }
                } else {
                    Text(formatToCurrency(CGFloat(value)))
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            withAnimation {
                                isEditing = true
                            }
                        }
                }

                Button(action: {
                    withAnimation {
//                        isEditing.toggle()
                        if isEditing {
                            if let parsed = inputText.toIntOrNil() {
                                value = Double(parsed)
                            }
                        } else {
                            inputText = formatToCurrency(CGFloat(value))
                        }
                        isEditing.toggle()
                    }
                }) {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(isEditing ? .gray : .black)
                        .bold()
                }
                .padding(.trailing, 16)
            }
            .padding(.vertical, 14)
            .padding(.leading, 16)
            .background(Color(.systemGray6))
            
            
            Text("Saran batas pinjaman aman: \(formatToCurrency(viewModel.safeLoanAmount > 100_000_000 ? 100_000_000 : viewModel.safeLoanAmount.rounded()))")
                .font(.footnote)
                .foregroundColor(.gray)

            NominalSlider(
                value: $value,
                range: 500_000...100_000_000,
                step: 100_000,
                safeColor: .green,
                riskColor: .orange,
                dangerousColor: .red,
                riskThreshold1: viewModel.riskThreshold1,
                riskThreshold2: viewModel.riskThreshold2
            )

            HStack {
                Text("Rp 500.000")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("Rp 100.000.000")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Text("*Limit pinjaman tiap platform dapat bervariasi")
                .font(.caption)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}


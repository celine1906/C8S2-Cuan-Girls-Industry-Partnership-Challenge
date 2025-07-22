import SwiftUI

struct InputTrackerView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var avgIncome: String = ""
    @State private var lowestIncome: String = ""
    @State private var avgExpense: String = ""
    @State private var hasInstallment: Bool? = nil
    @State private var installmentAmount: String = ""

    private let currencyFormatter = NumberFormatter.rupiah

    var body: some View {
        VStack(spacing: 24) {
            Text("Data ini akan kami gunakan untuk memahami kapasitas finansialmu sebelum mengajukan pinjaman")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(10) // jarak dalam kotak
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.top, 20)

            Group {
                InputField(label: "Rata-rata pendapatan bersih", value: $avgIncome)
                    .onChange(of: avgIncome) { _ in formatCurrencyText(&avgIncome) }

                InputField(label: "Pendapatan bersih terendah yang pernah didapatkan", value: $lowestIncome)
                    .onChange(of: lowestIncome) { _ in formatCurrencyText(&lowestIncome) }

                InputField(label: "Rata-rata pengeluaran", value: $avgExpense)
                    .onChange(of: avgExpense) { _ in formatCurrencyText(&avgExpense) }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Apakah kamu punya cicilan?")
                    .font(.body)

                HStack(spacing: 24) {
                    RadioButton(title: "Ya", isSelected: hasInstallment == true) {
                        hasInstallment = true
                    }
                    RadioButton(title: "Tidak", isSelected: hasInstallment == false) {
                        hasInstallment = false
                    }
                }
            }
            .padding(.trailing, 145)

            if hasInstallment == true {
                InputField(label: "Nominal cicilan", value: $installmentAmount)
                    .onChange(of: installmentAmount) { _ in formatCurrencyText(&installmentAmount) }
            }

            Spacer()

            Button(action: {
                // Validasi
            }) {
                Text("Cek Status Finansial")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .navigationTitle("Simulasi Peminjaman")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.gray)
                        .imageScale(.medium)
                }
            }
        }
        .background(Color(.systemGray6))
    }

    private func formatCurrencyText(_ text: inout String) {
        let raw = text.replacingOccurrences(of: ".", with: "")
        if let doubleVal = Double(raw) {
            text = currencyFormatter.string(from: NSNumber(value: doubleVal)) ?? ""
        }
    }
}

struct InputTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            InputTrackerView()
        }
    }
}

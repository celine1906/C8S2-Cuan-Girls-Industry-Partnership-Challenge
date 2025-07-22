import SwiftUI

struct InputReasonView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var itemName: String = ""
    @State private var itemPrice: Double = 0
    @State private var itemPriceText: String = ""
    @State private var isIncomeFluctuating: Bool? = nil
    
    private let currencyFormatter = NumberFormatter.rupiah
    
    var body: some View {
        VStack(spacing: 24) {
            // Icon
            Image("walletIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
                .padding(.top, 32)

            // Form
            VStack(alignment: .leading, spacing: 16) {
                Text("Apa yang ingin kamu beli?")
                    .font(.subheadline)
                
                TextField("Aku mau beli...", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Nominal barang")
                    .font(.subheadline)
                
                TextField("Rp 0", text: $itemPriceText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: itemPriceText) { newValue in
                        let raw = newValue.replacingOccurrences(of: ".", with: "")
                        if let doubleValue = Double(raw) {
                            itemPrice = doubleValue
                            itemPriceText = currencyFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
                        } else {
                            itemPrice = 0
                        }
                    }
                    .onAppear {
                        if itemPrice > 0 {
                            itemPriceText = currencyFormatter.string(from: NSNumber(value: itemPrice)) ?? ""
                        }
                    }

                Text("Apakah pendapatanmu fluktuatif?")
                    .font(.subheadline)

                HStack {
                    RadioButton(title: "Ya", isSelected: isIncomeFluctuating == true) {
                        isIncomeFluctuating = true
                    }
                    RadioButton(title: "Tidak", isSelected: isIncomeFluctuating == false) {
                        isIncomeFluctuating = false
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            // Tombol navigasi
            NavigationLink(destination: InputTrackerView()) {
                Text("Lanjut")
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
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .imageScale(.medium)
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

struct InputReasonView_Previews: PreviewProvider {
    static var previews: some View {
        InputReasonView()
    }
}


import SwiftUI

struct InputReasonView: View {
    @FocusState private var isPriceFieldFocused: Bool

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = UserWantsViewModel()

    var body: some View {
        VStack(spacing: 24) {
            Image("walletIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .padding(.top, 32)

            VStack(alignment: .leading, spacing: 16) {
                Text("Apa yang ingin kamu beli?")
                    .font(.subheadline)
                
                TextField("Aku mau beli...", text: $viewModel.itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Text("Nominal barang")
                    .font(.subheadline)

                TextField("Rp 0", text: $viewModel.rawItemPriceText)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: viewModel.rawItemPriceText) {
                        formatCurrency(&viewModel.rawItemPriceText)
                    }

                // Pesan error
                if viewModel.isPriceTooLow {
                    Text("Minimal peminjaman pada P2P Lending adalah Rp 500.000")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                if viewModel.isPriceTooHigh {
                    Text("Maksimal peminjaman pada P2P Lending adalah Rp 100.000.000")
                        .font(.caption)
                        .foregroundColor(.red)
                }

                Text("Apakah pendapatanmu fluktuatif?")
                    .font(.subheadline)

                HStack {
                    RadioButton(title: "Ya", isSelected: viewModel.isIncomeFluctuating == true) {
                        viewModel.isIncomeFluctuating = true
                    }
                    RadioButton(title: "Tidak", isSelected: viewModel.isIncomeFluctuating == false) {
                        viewModel.isIncomeFluctuating = false
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()


            Button(action: {
                if viewModel.isFormValid {
                    viewModel.save()
                    viewModel.isNavigating = true
                }
            }) {
                Text("Lanjut")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFormValid ? Color.white : Color.gray.opacity(0.4))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }
            .disabled(!viewModel.isFormValid)
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
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if let userWants = viewModel.userWants {
                InputTrackerView(userWants: userWants)
            }
        }

    }
}

#Preview {
    InputReasonView()
}

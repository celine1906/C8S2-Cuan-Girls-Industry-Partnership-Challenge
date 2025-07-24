import SwiftUI

struct InputReasonView: View {
    @FocusState private var isPriceFieldFocused: Bool

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = UserWantsViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Image(.input1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Apa yang ingin kamu beli?")
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 12)
                
                TextField("Aku mau beli...", text: $viewModel.itemName)
                    .font(.body)
                    .fontWeight(.regular)
                    .padding(16)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue.tertiary, lineWidth: 1)
                    )
                    .cornerRadius(8)
                    .padding(.bottom, 16)


                Text("Nominal barang")
                    .font(.subheadline)
                    .bold()
                
                VStack (alignment: .leading) {
                    TextField("Rp 0", text: $viewModel.rawItemPriceText)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.rawItemPriceText) {
                            formatCurrency(&viewModel.rawItemPriceText)
                        }
                        .font(.body)
                        .fontWeight(.regular)
                        .padding(16)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue.tertiary, lineWidth: 1)
                        )
                        .cornerRadius(8)

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
                }
                .padding(.bottom, 28)

                
                Text("Apakah pendapatanmu fluktuatif?")
                    .font(.subheadline)
                    .bold()

                HStack {
                    RadioButton(title: "Ya", isSelected: viewModel.isIncomeFluctuating == true) {
                        viewModel.isIncomeFluctuating = true
                    }
                    Spacer()
                    RadioButton(title: "Tidak", isSelected: viewModel.isIncomeFluctuating == false) {
                        viewModel.isIncomeFluctuating = false
                    }
                    Spacer()
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
                    .background(viewModel.isFormValid ? Color.button : Color.buttonSecondary)
                    .foregroundColor(.white)
                    .cornerRadius(12)
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
                        .imageScale(.large)
                        .bold()
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if let userWants = viewModel.userWants {
                InputTrackerView(userWants: userWants)
            }
        }
        .background(Color(.secondaryBlue).ignoresSafeArea())
    }
}

//#Preview {
//    InputReasonView()
//}


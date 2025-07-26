// Input Simulasi

import SwiftUI

struct InputSimulationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: InputSimulationViewModel
    @State private var showPlatformList = false

    let tenorsOptions = [30, 90, 180, 365]
    
    private var statusText: Text {
        switch viewModel.loanStatus {
        case .green: return Text("Cicilan **sudah di bawah** sisa uangmu.")
        case .yellow: return Text("Cicilan **hampir sama dengan** sisa uangmu.")
        case .red: return Text("Cicilan **sudah melebihi** sisa uangmu.")
        }
    }

    private var statusColor: Color {
        switch viewModel.loanStatus {
        case .green: return .sisaAman
        case .yellow: return .yellow
        case .red: return .red
        }
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                NominalInputCard(value: $viewModel.loanAmount, viewModel: viewModel)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            VStack (alignment: .leading, spacing: 8) {
                Text("Platform P2P legal dan bunganya")
                    .font(.subheadline)
                    .bold()

                PlatformPicker(
                    selectedPlatform: $viewModel.selectedPlatform,
                    showList: $showPlatformList,
                    platforms: viewModel.availablePlatforms
                )
                .padding(.top, 4)

                Text("*Simulasi akan mengenakan angka bunga \(viewModel.selectedPlatform.maxInterest, specifier: "%.1f")%.")
                    .font(.caption)

                TenorPicker(
                    selected: $viewModel.selectedTenor,
                    options: tenorsOptions
                )

                StatusMessage(
                    title: "Cicilan Bulanan",
                    amount: formatToCurrency(viewModel.monthlyInstallment.rounded()),
                    message: statusText,
                    color: statusColor,
                    income: formatToCurrency(CGFloat(viewModel.userRestIncome))
                )
                .padding(.top, 12)

            }
            .padding()
            .padding(.top, 4)
            .background(.inputField)
            .padding(.top, 12)
            
            Button(action: {
                viewModel.saveLoandata()
                viewModel.isNavigating.toggle()
            }) {
                Text("Lihat Detail")
                    .font(.subheadline)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.loanStatus == .red ? Color.button.opacity(0.5) : Color.button)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 16)
            .disabled(viewModel.loanStatus == .red)
            
            Spacer()
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
        .background(Color(.secondaryBlue).ignoresSafeArea())
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if let calculatedResult = viewModel.calculationResult {
                SimulasiPinjaman(viewModel: SimulasiPinjamanViewModel(loanCalculation: calculatedResult))
            }
        }
    }
}


#Preview {
    
    NavigationStack {
        let dummyUserFinancial = UserFinancial(
            id: 1,
            avgIncome: 5_000_000,
            lowestIncome: 3_000_000,
            avgExpense: 2_000_000,
            hasInstallment: true,
            installmentAmount: 500_000
        )

        let dummyUserWants = UserWants(
            id: 1,
            itemName: "Handphone Baru",
            itemPrice: 1_500_000,
            isIncomeFluctuating: false
        )

        let viewModel = InputSimulationViewModel(userFinancial: dummyUserFinancial, userWants: dummyUserWants)

        InputSimulationView(viewModel: viewModel)
    }
   
}

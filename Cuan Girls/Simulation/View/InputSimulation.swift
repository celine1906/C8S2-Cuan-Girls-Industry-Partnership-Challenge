// Input Simulasi

import SwiftUI

struct InputSimulationView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: InputSimulationViewModel
    @State private var showPlatformList = false

    let tenorsOptions = [30, 90, 180, 365]
    
    private var statusText: String {
        switch viewModel.loanStatus {
        case .green: return "Cicilan sudah di bawah 30% pendapatanmu."
        case .yellow: return "Cicilan sudah di atas 30% pendapatanmu."
        case .red: return "Cicilan melebihi sisa pendapatanmu."
        }
    }

    private var statusColor: Color {
        switch viewModel.loanStatus {
        case .green: return .green
        case .yellow: return .yellow
        case .red: return .red
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                NominalInputCard(value: $viewModel.loanAmount, viewModel: viewModel)
            }
            .padding(16)
            
            Spacer()
            
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
                    amount: viewModel.monthlyInstallment,
                    message: statusText,
                    color: statusColor
                )
                .padding(.top, 36)

            }
            .padding()
            .padding(.top, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.inputField)
            .padding(.top, 12)
            
            Spacer()

            LihatDetailButton(title: "Lihat Detail") {
                print("Lihat Detail button tapped!")
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
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
    }
}


#Preview {
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

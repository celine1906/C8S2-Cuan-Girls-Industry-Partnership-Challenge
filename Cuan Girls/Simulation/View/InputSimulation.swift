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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Platform P2P legal dan bunganya")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    PlatformPicker(
                        selectedPlatform: $viewModel.selectedPlatform,
                        showList: $showPlatformList,
                        platforms: viewModel.availablePlatforms
                    )
                    .padding(.horizontal)

                    Text("*Simulasi akan mengenakan angka bunga \(viewModel.selectedPlatform.maxInterest, specifier: "%.1f")%.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal)

                    TenorPicker(
                        selected: $viewModel.selectedTenor,
                        options: tenorsOptions
                    )
                    .padding(.horizontal)
                    
                    NominalInputCard(value: $viewModel.loanAmount, viewModel: viewModel)
                        .padding(.horizontal)

                    StatusMessage(
                        title: "Cicilan Bulanan",
                        amount: viewModel.monthlyInstallment,
                        message: statusText,
                        color: statusColor,
                        viewModel: viewModel
                    )
                    .padding(.horizontal)

                    Spacer()

                    LihatDetailButton(title: "Lihat Detail") {
                        print("Lihat Detail button tapped!")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}


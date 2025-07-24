import SwiftUI

struct RekomendasiFinansial: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: RekomendasiFinansialViewModel

    var body: some View {
        VStack (alignment: .leading, spacing: 12) {
            Image(.input1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        
            VStack(spacing: 8) {
                Text("Sisa uang kamu ")
                    .font(.headline)
                    .fontWeight(.bold) +
                Text("\(Int(viewModel.persenSisa))%")
                    .foregroundColor(viewModel.status.color)
                    .fontWeight(.bold)
                    .font(.headline) +
                Text(" dari pendapatan")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Bar(pengeluaran: viewModel.pengeluaranRatio, cicilan: viewModel.cicilanRatio, sisaColor: viewModel.status.color)
                    .padding(.horizontal, 20)
                
                VStack(alignment: .center, spacing: 8) {
                    HStack {
                        Text("Total pendapatan")
                        Spacer()
                        Text("Rp" + viewModel.formatToCurrency(viewModel.pendapatan))
                    }
                    .padding(.top, 8)

                    HStack {
                        Label("Pengeluaran", systemImage: "square.fill")
                            .foregroundColor(.pengeluaran)
                            .labelStyle(.iconOnly)
                        Text("Pengeluaran")
                        Spacer()
                        Text("Rp" + viewModel.formatToCurrency(viewModel.pengeluaran))
                    }

                    HStack {
                        Label("Cicilan", systemImage: "square.fill")
                            .foregroundColor(.cicilan)
                            .labelStyle(.iconOnly)
                        Text("Cicilan")
                        Spacer()
                        Text("Rp" + viewModel.formatToCurrency(viewModel.cicilan))
                    }

                    HStack {
                        Label("Cicilan", systemImage: "square.fill")
                            .foregroundColor(viewModel.status.color)
                            .labelStyle(.iconOnly)
                        Text("Sisa uangmu")
                        Spacer()
                        Text("Rp" + viewModel.formatToCurrency(viewModel.sisa))
                    }
                    .foregroundColor(viewModel.status.color)
                }
                .font(.subheadline)
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.top, 16)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
            
            RecommendationCard(status: viewModel.status)
                .padding()

            Spacer()
            
            Button(viewModel.status.buttonText) {
                viewModel.isNavigating.toggle()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.button)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding()
            .padding(.bottom, 42)
        }
        .navigationTitle("Rekomendasi Finansial")
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
            if viewModel.status == .tidakDisarankan {
                LoanHomeView()
            } else {
                InputSimulationView(viewModel: InputSimulationViewModel(userFinancial: viewModel.userFinancial, userWants: viewModel.userWants))
            }
        }
        .background(Color(.secondaryBlue).ignoresSafeArea())
    }
}

//#Preview {
//    let savedUserFinancial = UserFinancial(
//        id: 1,
//        avgIncome: 5_000_000,
//        lowestIncome: 4_000_000,
//        avgExpense: 3_500_000,
//        hasInstallment: true,
//        installmentAmount: 500_000
//    )
//
//    let userWants = UserWants(id: 1, itemName: "iPhone 14", itemPrice: 15_000_000, isIncomeFluctuating: false)
//
//    let viewModel = RekomendasiFinansialViewModel(userFinancial: savedUserFinancial, userWants: userWants)
//
//    RekomendasiFinansial(viewModel: viewModel)
//
//}


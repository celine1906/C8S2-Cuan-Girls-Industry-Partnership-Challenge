import SwiftUI

struct RekomendasiFinansial: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: RekomendasiFinansialViewModel

    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                Color.background
                    .ignoresSafeArea(edges: .bottom)

                VStack {
                    ScrollView {
                        VStack {
                            Text("Sisa uang kamu ") +
                            Text("\(Int(viewModel.persenSisa))%")
                                .foregroundColor(viewModel.status.color)
                                .fontWeight(.bold) +
                            Text(" dari pendapatan")

                            Bar(pengeluaran: viewModel.pengeluaranRatio, cicilan: viewModel.cicilanRatio)
                                .padding(.horizontal, 20)

                            VStack(alignment: .center, spacing: 8) {
                                HStack {
                                    Text("Total pendapatan")
                                    Spacer()
                                    Text("Rp" + viewModel.formatToCurrency(viewModel.pendapatan))
                                }

                                HStack {
                                    Label("Pengeluaran", systemImage: "square.fill")
                                        .foregroundColor(.black)
                                        .labelStyle(.iconOnly)
                                    Text("Pengeluaran")
                                    Spacer()
                                    Text("Rp" + viewModel.formatToCurrency(viewModel.pengeluaran))
                                }

                                HStack {
                                    Label("Cicilan", systemImage: "square.fill")
                                        .foregroundColor(.gray)
                                        .labelStyle(.iconOnly)
                                    Text("Cicilan")
                                    Spacer()
                                    Text("Rp" + viewModel.formatToCurrency(viewModel.cicilan))
                                }

                                HStack {
                                    Text("Sisa uangmu")
                                    Spacer()
                                    Text("Rp" + viewModel.formatToCurrency(viewModel.sisa))
                                }
                                .foregroundColor(viewModel.status.color)
                            }
                            .font(.subheadline)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                        RecommendationCard(status: viewModel.status)
                            .padding(20)
                    }
                    .padding(.top, 20)

                    Button(viewModel.status.buttonText) {
                        viewModel.isNavigating.toggle()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.button)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
        .navigationTitle("Rekomendasi Finansial")
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if viewModel.status == .tidakDisarankan {
                LoanHomeView()
            } else {
                InputSimulationView(viewModel: InputSimulationViewModel(userFinancial: viewModel.userFinancial, userWants: viewModel.userWants))
            }
        }
    }
}

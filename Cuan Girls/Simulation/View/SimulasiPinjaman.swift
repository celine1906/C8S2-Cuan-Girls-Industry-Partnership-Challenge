
import SwiftUI

struct SimulasiPinjaman: View {
    enum SimulasiTab: String, CaseIterable {
        case tepatWaktu = "Tepat Waktu"
        case telat1Bulan = "Telat 1 Bulan"
        case telat3Bulan = "Telat 3 Bulan"
    }
    
    @State private var selectedTab: SimulasiTab = .tepatWaktu
    @StateObject var viewModel: SimulasiPinjamanViewModel

    var body: some View {
        ZStack  {
            Color.blueBackground
                .ignoresSafeArea(edges: .bottom)
            
            VStack (alignment: .center){
                HStack {
                    ForEach(SimulasiTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.rawValue)
                                .fontWeight(selectedTab == tab ? .semibold : .regular)
                                .padding(10)
                                .foregroundColor(selectedTab == tab ? Color.black : Color.gray)
                                .background(selectedTab == tab ? Color.white : Color.clear)
                                .cornerRadius(8)
                                .font(.subheadline)
                        }
                        .disabled(selectedTab == tab)
                    }
                }
                .padding(.bottom, 16)
                .cornerRadius(8)
                
                ScrollView {
                    VStack {
                        VStack(alignment: .leading, spacing: 12) {
                            infoRow(label: "Nominal Pinjaman", value: "Rp \(formatToCurrency(viewModel.loanCalculation.loanAmount))")
                            infoRow(label: "Bunga Harian \(viewModel.loanCalculation.interestPerDay)%", value: "Rp \(formatToCurrency(viewModel.loanCalculation.dailyInterestRate))")
                            infoRow(label: "Tenor", value: "\(viewModel.loanCalculation.tenorInDays) hari")
                            

                            if selectedTab == .telat1Bulan {
                                infoRow(
                                    label: "Total Bunga",
                                    value: "Rp \(formatToCurrency(viewModel.getLateInterest(month: 1)))",
                                    valueColor: .black,
                                    isBold: true
                                )
                                HStack(alignment: .top, spacing: 4) {
                                    VStack (alignment: .leading) {
                                        Text("Telat 1 Bulan")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                        
                                        Text("*Penalti harian (0,1%)")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                   
                                    Spacer()
                                    
                                    Text("+ Rp" + formatToCurrency(viewModel.getPenaltyInterest(month: 1)))
                                        .foregroundColor(.red)
                                }
                                .padding()
                                .background(Color.red.opacity(0.1))
                                
                            } else if selectedTab == .telat3Bulan {
                                infoRow(
                                    label: "Total Bunga",
                                    value: "\(formatToCurrency(viewModel.getLateInterest(month: 3)))",
                                    valueColor: .black,
                                    isBold: true)
                                HStack(alignment: .top, spacing: 4) {
                                    VStack (alignment: .leading) {
                                        Text("Telat 3 Bulan")
                                            .font(.subheadline)
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                        
                                        Text("*Penalti harian (0,1%)")
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                   
                                    Spacer()
                                    
                                    Text("+ Rp" + formatToCurrency(viewModel.getPenaltyInterest(month: 3)))
                                        .foregroundColor(.red)
                                }
                                .padding()
                                .background(Color.red.opacity(0.1))
                                
                            } else {
                                infoRow(label: "Total Bunga", value: "+Rp \(formatToCurrency(viewModel.loanCalculation.totalInterest))", valueColor: .black, isBold: true)
                            }
                            
                            Divider()

                            if selectedTab == .telat1Bulan {
                                HStack (alignment: .center) {
                                    Text("Total Pelunasan")
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Image(systemName: "triangle.fill")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                    
                                    Text("Rp " + formatToCurrency(viewModel.getTotalRepayment(month: 1)))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 4)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)
                            } else if selectedTab == .telat3Bulan {
                                HStack (alignment: .center) {
                                    Text("Total Pelunasan")
                                        .bold()
                                    
                                    Spacer()
                                    
                                    Image(systemName: "triangle.fill")
                                        .foregroundColor(.red)
                                        .font(.caption)
                                    
                                    Text("Rp " + formatToCurrency(viewModel.getTotalRepayment(month: 3)))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                }
                                .padding(.top, 4)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 16)
                            } else {
                                infoRow(label: "Total Pelunasan", value: "Rp " + formatToCurrency(viewModel.loanCalculation.totalRepayment), valueColor: .black)
                            }
                                

                            if selectedTab == .tepatWaktu {
                                infoRow(label: "Cicilan Bulanan", value: "Rp " + formatToCurrency(viewModel.loanCalculation.monthlyInstallment), valueColor: .black)
                                    .padding(.bottom, 12)
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)

                        
                        VStack(alignment: .leading, spacing: 16) {
                            tipsRow(icon: "warning", color: .orange, title: "Telat di atas 90 hari berarti gagal bayar", subtitle: "akibatnya akses pinjamanmu akan dibatasi.")

                            Divider()
                            
                            tipsRow(icon: "lamp", color: .yellow, title: "Perhatikan jumlah total pelunasan,", subtitle: "bukan hanya cicilan per bulan.")
                            
                            Divider()
                            
                            tipsRow(icon: "clock", color: .blue, title: "Selalu bayar tepat waktu", subtitle: "hindari denda & jaga skor kreditmu.")
                
                        }
                        .padding()
                        .background(Color.tertiaryBlue)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.buttonSecondary, lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .padding(.top, 16)
                    }
                }
                Spacer()

                Text("*Limit pinjaman tiap platform dapat bervariasi. Jumlah yang dikalkulasikan hanya untuk keperluan simulasi.")
                    .font(.caption)
                    .padding(.top, 8)

                Button("Selesai") {
                    viewModel.isNavigating.toggle()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.button)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
            }
            .frame(maxHeight: .infinity, alignment: .leading)
            .padding(.top, 20)
            .navigationTitle("Detail Simulasi")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.isNavigating) {
                LoanHomeView()
            }
            
        }
    }

    func infoRow(label: String, value: String, valueColor: Color = .black, isBold: Bool = false) -> some View {
        HStack {
            Text(label)
                .bold()
            
            Spacer()
            
            Text(value)
                .foregroundColor(valueColor)
                .fontWeight(isBold ? .semibold : .regular)
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
        .padding(.top, 12)
    }

    func tipsRow(icon: String, color: Color, title: String, subtitle: String) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image(icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .padding(.leading, 12)
        }
    }
}

#Preview {
    let dummyLoanCalculation = LoanCalculationResult(
        loanAmount: 2_000_000,
        dailyInterestRate: 0.01,
        interestPerDay: 0.01,
        tenorInDays: 30,
        totalInterest: 600_000,
        totalRepayment: 2_600_000,
        monthlyInstallment: 866_667
    )
    
    let dummyViewModel = SimulasiPinjamanViewModel(loanCalculation: dummyLoanCalculation)

    return SimulasiPinjaman(viewModel: dummyViewModel)
}



import SwiftUI

struct InputTrackerView: View {
    let userWants: UserWants
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: InputTrackerViewModel
    
    init(userWants: UserWants) {
        self.userWants = userWants
        _viewModel = StateObject(wrappedValue: InputTrackerViewModel(userWants: userWants))
    }

    var body: some View {
        VStack(spacing: 24) {
            ScrollView {
                
            
            Text("Data ini akan kami gunakan untuk memahami kapasitas finansialmu sebelum mengajukan pinjaman")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(10)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.top, 20)

            Group {
                InputField(label: "Rata-rata pendapatan bersih", value: $viewModel.avgIncome)
                    .onChange(of: viewModel.avgIncome) {
                        formatCurrency(&viewModel.avgIncome)
                    }

                if viewModel.isIncomeFluctuating {
                    InputField(label: "Pendapatan bersih terendah yang pernah didapatkan", value: $viewModel.lowestIncome)
                        .onChange(of: viewModel.lowestIncome) {
                            formatCurrency(&viewModel.lowestIncome)
                        }
                }

                InputField(label: "Rata-rata pengeluaran", value: $viewModel.avgExpense)
                    .onChange(of: viewModel.avgExpense) {
                        formatCurrency(&viewModel.avgExpense)
                    }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Apakah kamu punya cicilan?")
                    .font(.body)

                HStack(spacing: 24) {
                    RadioButton(title: "Ya", isSelected: viewModel.hasInstallment == true) {
                        viewModel.hasInstallment = true
                    }
                    RadioButton(title: "Tidak", isSelected: viewModel.hasInstallment == false) {
                        viewModel.hasInstallment = false
                    }
                }
            }
            .padding(.trailing, 145)

            if viewModel.hasInstallment == true {
                InputField(label: "Nominal cicilan", value: $viewModel.installmentAmount)
                    .onChange(of: viewModel.installmentAmount) {
                        formatCurrency(&viewModel.installmentAmount)
                    }
            }

            Spacer()

            Button(action: {
                if viewModel.isFormValid {
                    viewModel.save()
                    viewModel.isNavigating.toggle()
                }
                
                
                print(viewModel.savedUserFinancial ?? "Gagal simpan")
            }) {
                Text("Cek Status Finansial")
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
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if let savedUserFinancial = viewModel.savedUserFinancial {
                RekomendasiFinansial(viewModel: RekomendasiFinansialViewModel(userFinancial: savedUserFinancial, userWants: userWants))
            }
        }
        }
    }
}


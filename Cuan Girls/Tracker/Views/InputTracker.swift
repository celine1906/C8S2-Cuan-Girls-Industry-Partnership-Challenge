import SwiftUI

struct InputTrackerView: View {
    let userWants: UserWants
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: InputTrackerViewModel
    @State private var isKeyboardVisible = false
    
    init(userWants: UserWants) {
        self.userWants = userWants
        _viewModel = StateObject(wrappedValue: InputTrackerViewModel(userWants: userWants))
    }

    var body: some View {
        VStack(spacing: 0) {
            
            if !isKeyboardVisible {
                Image(.input2)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .transition(.opacity)
            }
            
            ScrollView {
                VStack (alignment: .leading) {
                    Group {
                        InputField(label: "Rata-rata pendapatan bersih", value: $viewModel.avgIncome)
                            .onChange(of: viewModel.avgIncome) {
                                formatCurrency(&viewModel.avgIncome)
                            }
                            .padding(.bottom, 28)
                        
                        if viewModel.isIncomeFluctuating {
                            InputField(label: "Pendapatan bersih terendah yang pernah didapatkan", value: $viewModel.lowestIncome)
                                .onChange(of: viewModel.lowestIncome) {
                                    formatCurrency(&viewModel.lowestIncome)
                                }
                                .padding(.bottom, 28)
                        }
                        
                        InputField(label: "Rata-rata pengeluaran", value: $viewModel.avgExpense)
                            .onChange(of: viewModel.avgExpense) {
                                formatCurrency(&viewModel.avgExpense)
                            }
                            .padding(.bottom, 28)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Apakah kamu punya cicilan yang sedang berjalan?")
                            .font(.subheadline)
                            .bold()
                        
                        HStack(spacing: 24) {
                            RadioButton(title: "Ya", isSelected: viewModel.hasInstallment == true) {
                                viewModel.hasInstallment = true
                            }
                            
                            Spacer()
                            
                            RadioButton(title: "Tidak", isSelected: viewModel.hasInstallment == false) {
                                viewModel.hasInstallment = false
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    
                    if viewModel.hasInstallment == true {
                        InputField(label: "Nominal cicilan", value: $viewModel.installmentAmount)
                            .onChange(of: viewModel.installmentAmount) {
                                formatCurrency(&viewModel.installmentAmount)
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 28)
                    }
                }
                .padding(.top, 24)
            }
            .border(Color.gray.opacity(0.1), width: 1)
            
            VStack(spacing: 0) {
                
                Text("*Data ini akan kami gunakan untuk memahami kapasitas finansialmu sebelum mengajukan pinjaman.")
                    .lineLimit(nil)
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                
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
                        .background(viewModel.isFormValid ? Color.button : Color.buttonSecondary)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .disabled(!viewModel.isFormValid)
                .padding(.horizontal, 24)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation {
                isKeyboardVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation {
                isKeyboardVisible = false
            }
        }
        .navigationTitle("Simulasi Peminjaman")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.black)
                        .bold()
                }
            }
        }
        .navigationDestination(isPresented: $viewModel.isNavigating) {
            if let savedUserFinancial = viewModel.savedUserFinancial {
                RekomendasiFinansial(viewModel: RekomendasiFinansialViewModel(userFinancial: savedUserFinancial, userWants: userWants))
            }
        }
        .background(Color(.secondaryBlue).ignoresSafeArea())
    }
}

#Preview {
    let userWants = UserWants(id: 1, itemName: "iPhone 14", itemPrice: 15_000_000, isIncomeFluctuating: true)

    InputTrackerView(userWants: userWants)
}


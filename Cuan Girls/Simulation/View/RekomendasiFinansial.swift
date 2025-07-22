import SwiftUI

struct RekomendasiFinansial: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = RekomendasiFinansialViewModel()
    
    var body: some View {
        @State var pendapatan: CGFloat = 1000000
        @State var pengeluaran: CGFloat =  800000
        @State var cicilan: CGFloat = 100000
        let persenSisa = (pendapatan - pengeluaran - cicilan)/pendapatan * 100
        
        NavigationStack {
            ZStack (alignment: .center) {
                Color.background
                    .ignoresSafeArea(edges: .bottom)
                
                VStack{
                    ScrollView{
                        VStack{
                            if persenSisa < 30 {
                                Text("Sisa uang kamu ") +
                                Text("\(Int(persenSisa))%")
                                    .foregroundColor(.red)
                                    .fontWeight(.bold) +
                                Text(" dari pendapatan")
                            } else {
                                Text("Sisa uang kamu ") +
                                Text("\(Int(persenSisa))%")
                                    .foregroundColor(.green)
                                    .fontWeight(.bold) +
                                Text(" dari pendapatan")
                            }
                            
                            Bar(pengeluaran: pengeluaran/pendapatan, cicilan: cicilan/pendapatan)
                                .padding(.horizontal, 20)

                            VStack(alignment: .center, spacing: 8) {
                                HStack {
                                    Text("Total pendapatan")
                                    Spacer()
                                    Text("Rp" + formatToCurrency(pendapatan))
                                }
                                HStack {
                                    Label("Pengeluaran", systemImage: "square.fill")
                                        .foregroundColor(.black)
                                        .labelStyle(.iconOnly)
                                    Text("Pengeluaran")
                                    Spacer()
                                    Text("Rp" + formatToCurrency(pengeluaran))
                                }
                                HStack {
                                    Label("Cicilan", systemImage: "square.fill")
                                        .foregroundColor(.gray)
                                        .labelStyle(.iconOnly)
                                    Text("Cicilan")
                                    Spacer()
                                    Text("Rp" + formatToCurrency(cicilan))
                                }
                                if persenSisa < 30 {
                                    HStack {
                                        Text("Sisa uangmu")
                                        Spacer()
                                        Text("Rp" + formatToCurrency(pendapatan-pengeluaran-cicilan))
                                    }
                                    .foregroundColor(.red)
                                } else {
                                    HStack {
                                        Text("Sisa uangmu")
                                        Spacer()
                                        Text("Rp" + formatToCurrency(pendapatan-pengeluaran-cicilan))
                                    }
                                    .foregroundColor(.green)
                                }
                                
                            }
                            .font(.subheadline)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                        }
                        
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, minHeight: 181, maxHeight: .infinity)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                        VStack {
                            HStack {
                                Image(systemName: "bag.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 20)
                                
                                if persenSisa <= 0 {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Kamu tidak disarankan untuk melakukan peminjaman")
                                            .font(.subheadline.bold())

                                        Text("Ayo **tabung 30% dari pendapatanmu** setiap bulannya agar keuanganmu lebih sehat")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.trailing, 20)
                                } else if persenSisa < 30 {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Pengeluaran kamu cukup tinggi nih")
                                            .font(.subheadline.bold())

                                        Text("Coba **sisihkan minimal 30% dari pendapatanmu** untuk ditabung ya!\nTapi tenang, kamu tetap bisa lanjut simulasi kok")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.trailing, 20)
                                } else {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Pertahankan rasio pengeluaranmu")
                                            .font(.subheadline.bold())

                                        Text("agar tidak melebihi 30% dari pendapatanmu")
                                            .font(.caption)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.trailing, 20)
                                }

                                
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 139, maxHeight: .infinity)
                        .fixedSize(horizontal: false, vertical: true)
                        .background(.banner)
                        .cornerRadius(10)
                        .padding(20)
                        
                    }
                    .padding(.top, 20)
                    
                    if persenSisa <= 0 {
                        Button("Selesai") {
                            // Action
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.button)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                    } else {
                        Button("Mulai Simulasi") {
                            // Action
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
        }
        .navigationTitle("Rekomendasi Finansial")
    }
}



#Preview {
    RekomendasiFinansial()
}

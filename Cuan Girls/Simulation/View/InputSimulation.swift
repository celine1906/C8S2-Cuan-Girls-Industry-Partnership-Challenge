// Input Simulasi

import SwiftUI

struct InputSimulationView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var loanAmount: Double = 6_000_000
    @State private var selectedPlatform = Platform(name: "Pilih platform", interestRange: "-", maxInterest: 0)
    @State private var showPlatformList = false
    @State private var selectedTenor: Int = 180
    @State private var monthlyInstallment: String = "1.540.000"
    @State private var isAffordable: Bool = true

    let availablePlatforms: [Platform] = [
        Platform(name: "EasyCash", interestRange: "0.03% - 0.3%", maxInterest: 0.3),
        Platform(name: "AkuLaku", interestRange: "0.1% - 0.3%", maxInterest: 0.3),
        Platform(name: "AdaPundi", interestRange: "0.15% - 0.3%", maxInterest: 0.3),
        Platform(name: "Indosaku", interestRange: "0.02% - 0.3%", maxInterest: 0.3),
        Platform(name: "Kredivo", interestRange: "0.05% - 0.3%", maxInterest: 0.3)
    ]

    let tenorsOptions = [30, 90, 180, 270]

    var body: some View {
        NavigationView {
            ScrollView { // Tetap gunakan ScrollView untuk konten yang bisa memanjang
                VStack(alignment: .leading, spacing: 16) { // alignment .leading untuk teks
                    // Judul Platform P2P legal dan bunganya (di sini sekarang)
                    Text("Platform P2P legal dan bunganya")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.horizontal) // Berikan padding horizontal

                    // Platform Picker
                    PlatformPicker(
                        selectedPlatform: $selectedPlatform,
                        showList: $showPlatformList,
                        platforms: availablePlatforms
                    )
                    .padding(.horizontal) // Padding horizontal untuk PlatformPicker

                    // Teks simulasi bunga (di sini sekarang)
                    Text("*Simulasi akan mengenakan angka bunga \(selectedPlatform.maxInterest, specifier: "%.1f")%.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal) // Berikan padding horizontal

                    // 2. Tenor Picker
                    TenorPicker(
                        selected: $selectedTenor,
                        options: tenorsOptions
                    )
                    .padding(.horizontal)

                    // 3. Nominal Pinjaman
//                    NominalInputCard(value: $loanAmount, formatter: )
//                        .padding(.horizontal)

                    // 4. Status Message
                    StatusMessage(
                        title: "Cicilan Bulanan",
                        amount: "Rp \(monthlyInstallment)",
                        message: isAffordable
                            ? "Cicilan sudah di bawah 30% pendapatanmu."
                            : "Cicilan sudah di atas 30% pendapatanmu.",
                        isPositive: isAffordable
                    )
                    .padding(.horizontal)

                    Spacer()

                    // 5. Lihat Detail Button
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

struct InputSimulationView_Previews: PreviewProvider {
    static var previews: some View {
        InputSimulationView()
    }
}

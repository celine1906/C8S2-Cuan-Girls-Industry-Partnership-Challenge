import SwiftUI

struct LoanHomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                // Icon target
                Image(.homepage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 227, height: 227)

                // Text kosong
                VStack(spacing: 4) {
                    Text("Mulai simulasi peminjaman?")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    Text("Kamu belum memulai simulasi apapun")
                        .font(.subheadline)
                        .opacity(0.7)
                        .fontWeight(.regular)
                }

                Spacer()

                // Tombol navigasi
                NavigationLink(destination: InputReasonView()) {
                    Text("Mulai Simulasi")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.button)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .bold()
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Simulasi Peminjaman")
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
            .background(Color(.secondaryBlue).ignoresSafeArea())
        }
    }
}

struct LoanHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoanHomeView()
    }
}


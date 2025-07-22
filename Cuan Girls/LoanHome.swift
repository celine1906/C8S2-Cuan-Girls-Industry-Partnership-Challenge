import SwiftUI

struct LoanHomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                Spacer()

                // Icon target
                Image(systemName: "target")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)

                // Text kosong
                VStack(spacing: 4) {
                    Text("Mulai simulasi peminjaman?")
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Text("Kamu belum memulai simulasi apapun")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()

                // Tombol navigasi
                NavigationLink(destination: InputReasonView()) {
                    Text("Mulai Simulasi")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
            .navigationTitle("Simulasi Peminjaman")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6).ignoresSafeArea())
        }
    }
}

struct LoanHomeView_Previews: PreviewProvider {
    static var previews: some View {
        LoanHomeView()
    }
}


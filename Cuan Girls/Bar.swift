import SwiftUI

struct Bar: View {
    var pengeluaran: CGFloat
    var cicilan: CGFloat
    var sisa: CGFloat {
        max(0, 1 - pengeluaran - cicilan)
    }

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.pengeluaran)
                    .frame(width: geo.size.width * pengeluaran)

                Rectangle()
                    .fill(Color.cicilan)
                    .frame(width: geo.size.width * cicilan)

                Rectangle()
                    .fill(Color.sisa)
                    .frame(width: geo.size.width * sisa)
            }
            .frame(height: 16)
            .cornerRadius(8)
        }
        .frame(height: 16)
    }
}

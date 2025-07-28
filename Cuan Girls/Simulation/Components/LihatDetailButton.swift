// Tombol lihat detail di Input Simulasi
import SwiftUI

struct LihatDetailButton: View {
    let title: String
    let action: ()

    var body: some View {
        Button(action: {action}) {
            Text(title)
                .font(.subheadline)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(.button)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

// Tombol lihat detail di Input Simulasi
import SwiftUI

struct LihatDetailButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.black))
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }
}

struct LihatDetailButton_Previews: PreviewProvider {
    static var previews: some View {
        LihatDetailButton(title: "Lihat Detail") {
            print("Action button tapped!")
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

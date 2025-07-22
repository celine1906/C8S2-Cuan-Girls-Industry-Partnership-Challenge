import SwiftUI

struct InputField: View {
    var label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.body)

            HStack {
                TextField("Rp 0", text: $value)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )

                Text("/ bulan")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding(.leading, 4)
            }
        }
        .padding(.horizontal)
    }
}


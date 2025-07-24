import SwiftUI

struct InputField: View {
    var label: String
    @Binding var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.bold)

            HStack {
                TextField("Rp 0", text: $value)
                    .font(.body)
                    .fontWeight(.regular)
                    .padding(16)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue.tertiary, lineWidth: 1)
                    )
                    .cornerRadius(8)
                    .keyboardType(.numberPad)


                Text("/ bulan")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding(.leading, 4)
            }
        }
        .padding(.horizontal, 16)
    }
}


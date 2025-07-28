// Picker Tenor di Input Simulasi

import SwiftUI

struct TenorPicker: View {
    @Binding var selected: Int
    let options: [Int]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tenor Peminjaman")
                .font(.subheadline)
                .bold()

            HStack(spacing: 8) {
                ForEach(options, id: \.self) { tenor in
                    Button {
                        selected = tenor
                    } label: {
                        Text("\(tenor) hari")
                            .font(.subheadline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .background(selected == tenor ? Color.button : Color.clear)
                            .foregroundColor(selected == tenor ? .white : .black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selected == tenor ? Color.black : .gray.opacity(0.2))
                            )
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding(.top, 12)
    }
}

struct TenorPicker_Previews: PreviewProvider {
    @State static var selected = 90
    static var previews: some View {
        TenorPicker(selected: $selected, options: [30, 90, 180, 270])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}


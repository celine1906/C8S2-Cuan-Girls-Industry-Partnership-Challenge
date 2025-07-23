// Card Nominal Input + Slider di Input Simulasi

import SwiftUI

struct NominalInputCard: View {
    @Binding var value: Double
    let formatter: NumberFormatter

    // State untuk mengontrol apakah mode edit aktif
    @State private var isEditing: Bool = false
    // State untuk menyimpan input teks saat diedit
    @State private var inputText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nominal Pinjaman")
                .font(.headline)
                .foregroundColor(.gray)

            // Container untuk Nominal dan Pensil
            HStack {
                // Background dan Corner Radius untuk area Nominal
                Group {
                    // Teks "Rp" di luar TextField agar selalu terlihat
                    Text("Rp")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)

                    if isEditing {
                        // TextField yang bisa diedit
                        TextField("6.000.000", text: $inputText, onCommit: {
                            if let newValue = formatter.number(from: inputText)?.doubleValue {
                                value = newValue
                            }
                            isEditing = false // Keluar dari mode edit
                        })
                        .keyboardType(.numberPad)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .submitLabel(.done)
                        .onAppear {
                             
                             inputText = formatter.string(from: NSNumber(value: value))?.replacingOccurrences(of: "Rp ", with: "").replacingOccurrences(of: ".", with: "") ?? ""
                         }
                    } else {
                        
                        Text(formatter.string(from: NSNumber(value: value)) ?? "")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                withAnimation {
                                    isEditing = true
                                    inputText = formatter.string(from: NSNumber(value: value))?.replacingOccurrences(of: "Rp ", with: "").replacingOccurrences(of: ".", with: "") ?? ""
                                }
                            }
                    }
                }
                .padding(.vertical, 14)
                .padding(.leading, 16)


                Button(action: {
                    withAnimation {
                        isEditing.toggle()
                        // Jika masuk mode edit, inisialisasi inputText dengan nilai saat ini
                        if isEditing {
                            inputText = formatter.string(from: NSNumber(value: value))?.replacingOccurrences(of: "Rp ", with: "").replacingOccurrences(of: ".", with: "") ?? ""
                        } else {
                            if let newValue = formatter.number(from: inputText)?.doubleValue {
                                value = newValue
                            }
                        }
                    }
                }) {
                    Image(systemName: isEditing ? "checkmark.circle.fill" : "pencil")
                        .foregroundColor(isEditing ? .green : .gray) // Ganti warna ikon
                }
                .padding(.trailing, 16)
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)

            // Teks "Perkiraan batas pinjaman maximum"
            Text("Perkiraan batas pinjaman maximum: Rp 17.000.000") //
                .font(.footnote)
                .foregroundColor(.gray)

            // Slider
            NominalSlider(
                value: $value,
                range: 500_000...100_000_000,
                step: 100_000,
                safeColor: .green,
                riskColor: .orange,
                dangerousColor: .red,
                riskThreshold1: 0.3,
                riskThreshold2: 0.7
            )

            HStack {
                Text("Rp 500.000")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
                Text("Rp 100.000.000")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            // Teks "*Limit pinjaman tiap platform dapat bervariasi"
            Text("*Limit pinjaman tiap platform dapat bervariasi")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding() // Padding untuk seluruh card
        .background(Color.white) // Background putih untuk card
        .cornerRadius(12) // Corner radius untuk card
    }
}


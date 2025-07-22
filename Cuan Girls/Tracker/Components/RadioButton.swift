import SwiftUI

struct RadioButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.blue)
                Text(title)
                    .foregroundColor(.black)
            }
        }
        .padding(.trailing, 16)
    }
}


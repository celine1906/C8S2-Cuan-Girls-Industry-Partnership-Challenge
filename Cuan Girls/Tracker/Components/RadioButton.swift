import SwiftUI

struct RadioButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.button)
                Text(title)
                    .font(.body)
                    .fontWeight(.regular)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}



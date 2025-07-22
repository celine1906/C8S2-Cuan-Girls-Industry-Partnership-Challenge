// Picker Platform di Input Simulasi

import SwiftUI

struct PlatformPicker: View {
    @Binding var selectedPlatform: Platform
    @Binding var showList: Bool
    let platforms: [Platform]

    var body: some View {
        VStack(spacing: 0) {
            Button {
                withAnimation {
                    showList.toggle()
                }
            } label: {
                HStack {
                    Text(selectedPlatform.name)
                        .foregroundColor(.black)
                    Spacer()
                    Text(selectedPlatform.interestRange)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Image(systemName: showList ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black)
                        .cornerRadius(8)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3))
                )
            }
            
            if showList {
                VStack(spacing: 0) {
                    ForEach(platforms) { platform in
                        Button {
                            withAnimation {
                                selectedPlatform = platform
                                showList = false
                            }
                        } label: {
                            HStack {
                                Text(platform.name)
                                    .foregroundColor(.black)
                                    .font(.body)
                                Spacer()
                                Text(platform.interestRange)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(selectedPlatform.id == platform.id ? Color.blue.opacity(0.1) : Color.white)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray.opacity(0.3))
                )
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                .frame(maxWidth: .infinity)
                
                .transition(.opacity.animation(.easeOut(duration: 0.2))) 
            }
        }
    }
}

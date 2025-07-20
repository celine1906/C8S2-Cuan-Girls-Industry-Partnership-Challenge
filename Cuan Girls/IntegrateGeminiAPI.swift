//
//  IntegrateGeminiAPI.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 20/07/25.
//

import SwiftUI
import GoogleGenerativeAI

struct IntegrateGeminiAPI: View {
    let model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    @State private var inputText: String = ""
    @State private var generatedText: LocalizedStringKey? = nil
    @State private var isGenerating: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                TextField("Input text", text: $inputText, axis: .vertical)
                    .lineLimit(10)
                    .padding()
                Button(action: {
                    generateText()
                }) {
                    if isGenerating {
                        ProgressView().scaleEffect(4)
                    } else {
                        Text("Generate")
                    }
                }
                
                if let result = generatedText {
                    Text(result)
                        .font(.caption)
                }
            }
        }
        .padding()
    }
    
    func generateText() {
        isGenerating = true
        generatedText = ""
        
        Task {
            do {
                let result = try await model.generateContent(inputText)
                await MainActor.run {
                    self.generatedText = LocalizedStringKey(result.text ?? "No response")
                    self.inputText = ""
                    self.isGenerating = false
                }
            } catch {
                await MainActor.run {
                    self.generatedText = "Error generating text: \(error.localizedDescription)"
                    print(error)
                    self.isGenerating = false
                }
            }
        }
    }

}

#Preview {
    IntegrateGeminiAPI()
}

// Slider Nominal di Input Simulasi

import SwiftUI

struct NominalSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    
    let safeColor: Color
    let riskColor: Color
    let dangerousColor: Color
    
    let riskThreshold1: Double // e.g., 0.3
    let riskThreshold2: Double // e.g., 0.7

    var body: some View {
        Slider(value: $value, in: range, step: step)
            .accentColor(.clear)
            .overlay(GeometryReader { geometry in
                let width = geometry.size.width
                let normalizedValue = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
                let thumbX = CGFloat(normalizedValue) * width
                
                let threshold1X = CGFloat(riskThreshold1) * width
                let threshold2X = CGFloat(riskThreshold2) * width

                ZStack(alignment: .leading) {
                    // BACKGROUND ZONES
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(safeColor)
                            .frame(width: threshold1X, height: 4)
                        Rectangle()
                            .fill(riskColor)
                            .frame(width: threshold2X - threshold1X, height: 4)
                        Rectangle()
                            .fill(dangerousColor)
                            .frame(width: width - threshold2X, height: 4)
                    }
                    .frame(height: 4)
                    .position(x: width / 2, y: geometry.size.height / 2)

                    // PROGRESS FILL
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(safeColor)
                            .frame(width: min(thumbX, threshold1X), height: 4)

                        if thumbX > threshold1X {
                            Rectangle()
                                .fill(riskColor)
                                .frame(width: min(thumbX - threshold1X, threshold2X - threshold1X), height: 4)
                        }

                        if thumbX > threshold2X {
                            Rectangle()
                                .fill(dangerousColor)
                                .frame(width: thumbX - threshold2X, height: 4)
                        }
                    }
                    .frame(height: 4)
                    .position(x: thumbX / 2, y: geometry.size.height / 2) 
                }
            })
    }
}

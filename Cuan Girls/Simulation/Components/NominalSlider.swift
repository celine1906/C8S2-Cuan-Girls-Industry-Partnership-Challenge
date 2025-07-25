// Slider Nominal di Input Simulasi

import SwiftUI

struct NominalSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    
    let safeColor: Color
    let riskColor: Color
    let dangerousColor: Color
    
    let riskThreshold1: Double
    let riskThreshold2: Double

    var body: some View {
        Slider(value: $value, in: range, step: step)
            .accentColor(.clear)
            .overlay( GeometryReader { geometry in
                let width = geometry.size.width
                let threshold1X = CGFloat(riskThreshold1) * width
                let threshold2X = CGFloat(riskThreshold2) * width
                
                GeometryReader { geo in
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(safeColor)
                            .frame(width:threshold1X, height: 12)
                        Rectangle()
                            .fill(riskColor)
                            .frame(width: threshold2X - threshold1X, height: 12)
                        Rectangle()
                            .fill(dangerousColor)
                            .frame(width: width * threshold2X, height: 12)
                    }
                    .frame(height: 12)
                    .cornerRadius(12)
                }
                .cornerRadius(12)
                .frame(height: 12)
                .position(x: width / 2, y: geometry.size.height / 2)
                
            }
        )
    }
}

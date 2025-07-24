//
//  RecommendationCard.swift
//  Cuan Girls
//
//  Created by Regina Celine Adiwinata on 23/07/25.
//

import SwiftUI

struct RecommendationCard: View {
    let status: FinancialStatus

    var body: some View {
        HStack {
            Image(.bag)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)

            VStack(alignment: .leading, spacing: 6) {
                Text(status.title)
                    .font(.subheadline.bold())

                Text(status.message)
                    .font(.caption)
                    .fontWeight(.regular)
            }
            .padding(.leading, 8)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(.blue.tertiary)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
            .inset(by: 0.5)
            .stroke(.blue.secondary, lineWidth: 1)
        )
    }
}


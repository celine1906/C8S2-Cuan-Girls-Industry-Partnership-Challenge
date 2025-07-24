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
            Image(systemName: "bag.fill")
                .font(.system(size: 28))
                .foregroundColor(.blue)
                .padding()

            VStack(alignment: .leading, spacing: 6) {
                Text(status.title)
                    .font(.subheadline.bold())

                Text(status.message)
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.banner)
        .cornerRadius(10)
    }
}

// Data Platform P2P

import Foundation

struct Platform: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let interestRange: String
    let maxInterest: Double
}


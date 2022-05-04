//
// Created by Ivan Petukhov on 02.05.2022.
//

import Foundation
import SwiftUI

protocol GrowthFallColorable {
    var growthFallColor: Color { get }
}

extension Decimal: GrowthFallColorable {
    var growthFallColor: Color {
        self > 0 ? Color.growColor.opacity(doubleValue / 10) : Color.fallColor.opacity(-doubleValue / 10)
    }
}

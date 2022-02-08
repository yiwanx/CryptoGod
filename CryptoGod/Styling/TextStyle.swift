//
// Created by Ivan Petukhov on 04.01.2022.
//

import Foundation
import SwiftUI

enum TextStyle {
    case title
    case body
    case number
}

extension Color {
    public static let foreground = dynamicColor(light: Color(red: 0.04, green: 0.02, blue: 0.08), dark: Color.white)
    public static let growColor = Color(#colorLiteral(red: 0, green: 0.8335130215, blue: 0.4241684079, alpha: 1))
    public static let fallColor = Color(#colorLiteral(red: 1, green: 0, blue: 0.4943445921, alpha: 1))
}
extension Color {
    @Environment(\.colorScheme) static var colorScheme
    static func dynamicColor(light: Color, dark: Color) -> Color {
        if colorScheme == .light {
            return light
        } else {
            return dark
        }
    }
}


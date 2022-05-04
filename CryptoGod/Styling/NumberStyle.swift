//
// Created by Ivan Petukhov on 04.01.2022.
//

import Foundation
import SwiftUI

struct NumberStyle {
    enum PlaceHolder: String {
        case line = "-"
    }

    enum Currency: String {
        case usd = "$"
        case btc = "₿"
        case prc = "%"
        var withSpace: String {
            " \(rawValue)"
        }
    }

    static var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 4
        return formatter
    }()
}

extension Optional where Wrapped == NumberStyle.Currency {
    var withSpace: String {
        if let value = self {
            return value.withSpace
        } else {
            return NumberStyle.PlaceHolder.line.rawValue
        }
    }
}

extension Optional where Wrapped == Decimal {
    func string(with currency: NumberStyle.Currency? = nil) -> String {
        guard let num = self else { return NumberStyle.PlaceHolder.line.rawValue }
        return num.string(with: currency)
    }
}

extension Decimal {
    func string(with currency: NumberStyle.Currency? = nil) -> String {
        if let formatted = NumberStyle.valueFormatter.string(from: NSDecimalNumber(decimal: self)) {
            return formatted + (currency?.rawValue ?? "")
        } else {
            return NumberStyle.PlaceHolder.line.rawValue
        }
    }
}

extension Decimal {
    func coloredChangeText(with currency: NumberStyle.Currency? = nil) -> Text {
        if self > 0 {
            return Text(string(with: currency)).foregroundColor(.growColor).font(.body)
        } else {
            return Text(string(with: currency)).foregroundColor(.fallColor).font(.body)
        }
    }
}

extension Optional where Wrapped == Decimal {
    func coloredChangeText(with currency: NumberStyle.Currency? = nil) -> Text {
        guard let num = self else { return Text(NumberStyle.PlaceHolder.line.rawValue).font(.body)}
        return num.coloredChangeText(with: currency)
    }
}

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}

//
//  CryptoDetailsViewModel.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 09.01.2022.
//

import Foundation
import APIBase
import SwiftUI

class CryptoDetailsViewModel {

    let cellViewModels: [InfoCellViewModel]

    let backColor: Color

    init(crypto: Crypto) {
        cellViewModels = [
            InfoCellViewModel(name: Text(crypto.name).font(.largeTitle), value: Text(crypto.symbol).font(.title3)),
            InfoCellViewModel(name: "Price", value: crypto.quote?.USD?.price?.string(with: .usd) ?? ""),
            InfoCellViewModel(name: Text("1h Change"), value: crypto.quote?.USD?.percentChangeHour?.coloredChangeText(with: .prc)),
            InfoCellViewModel(name: Text("24h Change"), value: crypto.quote?.USD?.percentChangeDay?.coloredChangeText(with: .prc))
        ]
        backColor = crypto.quote?.USD?.percentChangeDay?.growthFallColor ?? .white
    }

    var view: CryptoDetailsView {
        .init(cellViewModels: cellViewModels, backColor: backColor)
    }
}

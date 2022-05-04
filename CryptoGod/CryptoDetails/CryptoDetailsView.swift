//
//  CryptoDetailsView.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 09.01.2022.
//

import Foundation
import SwiftUI

struct CryptoDetailsView: View {
    let cellViewModels: [InfoCellViewModel]
    let backColor: Color


    var body: some View {
        List(cellViewModels) { item in
            item.cell
        }.background(backColor)
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = .clear
                }
    }
}

public extension Optional where Wrapped == Decimal {
    @discardableResult
    func `let`<T>(_ closure: ((Wrapped) -> T)) -> T? {
        if let wrapped = self {
            return closure(wrapped)
        }
        return nil
    }
}

//
//  InfoCell.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 16.01.2022.
//

import Foundation
import SwiftUI

protocol Cellable {
    associatedtype Cell
    var cell: Cell { get }
}

struct InfoCellViewModel: Identifiable {
    let name: Text?
    let value: Text?
    let id = UUID()

    init(name: String, value: String) {
        self.name = Text(name).font(.title3)
        self.value = Text(value).font(.title3)
    }
    
    init(name: Text?, value: Text?) {
        self.name = name
        self.value = value
    }
}

extension InfoCellViewModel: Cellable {
    var cell: InfoCell {
        .init(name: name, value: value)
    }
}

struct InfoCell: View {
    let name: Text?
    let value: Text?
    var body: some View {
        HStack {
            name
            Spacer()
            value
        }
    }
}
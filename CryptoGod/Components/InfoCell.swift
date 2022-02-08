//
//  InfoCell.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 16.01.2022.
//

import Foundation
import SwiftUI

struct InfoCellViewModel: Identifiable {
    var id: UUID
    
    let name: Text?
    let value: Text?
    
    init(name: String, value: String, id: UUID = UUID()) {
        self.id = id
        self.name = Text(name).font(.title3)
        self.value = Text(value).font(.title3)
    }
    
    init(name: Text?, value: Text?, id: UUID = UUID()) {
        self.id = id
        self.name = name
        self.value = value
    }

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
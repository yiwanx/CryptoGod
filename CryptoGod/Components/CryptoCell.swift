//
// Created by Ivan Petukhov on 05.01.2022.
//

import Foundation
import SwiftUI

struct CryptoCell: View {
    let title: Text
    let price: Text
    let priceChangeTitle: Text?
    let priceChange: Text?
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    title
                    Spacer()
                    price
                }
                Spacer(minLength: 4)
                HStack {
                    priceChangeTitle
                    Spacer()
                    priceChange
                }
            }
        }
    }
}

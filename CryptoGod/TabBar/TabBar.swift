//
// Created by Ivan Petukhov on 03.05.2022.
//

import Foundation
import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            CryptoListView()
                .tabItem {
                    Label("Menu", systemImage: "heart")
                }
        }
    }
}


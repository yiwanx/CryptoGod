//
//  CryptoTopView.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation
import SwiftUI
import APIBase

struct CryptoListView: View {
    @StateObject var viewModel = CryptoListViewModel()

    fileprivate func listRow(_ crypto: Crypto) -> some View {
        let dayChange = crypto.quote?.USD?.percentChangeDay
        return CryptoCell(
            title: Text(crypto.name).font(.title2),
            price: Text((crypto.quote?.USD?.price.string(with: .usd) ?? NumberStyle.Currency.prc.rawValue)).font(.title3),
            priceChangeTitle: Text("24h change").font(.body),
            priceChange: dayChange?.coloredChangeText(with: .prc)
        )
    }
    

    
    fileprivate func CryptoList() -> some View {
        NavigationView {
            List(viewModel.cryptos) { item in
                NavigationLink(destination: CryptoDetailsViewModel(crypto: item).view) {
                    listRow(item).padding(8)
                }
            }.listStyle(.plain)
            .task {
                await viewModel.getCryptos()
            }
            .alert("Error", isPresented: $viewModel.hasError) {
                Text(viewModel.errorMessage)
            }.navigationTitle("CryptoGod").navigationBarTitleDisplayMode(.inline).font(.title)
            
        }.padding(0)


    }

    var body: some View {
        CryptoList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoListView().navigationViewStyle(StackNavigationViewStyle()).preferredColorScheme(.dark)
    }
}

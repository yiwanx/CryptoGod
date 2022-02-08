//
//  CryptoListTopViewModel.swift
//  CryptoGod
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation
import APIBase
import Moya

@MainActor
class CryptoListViewModel: ObservableObject {
    
    
//    let interactor: BusinessLogic
//
//    init(_ interactor: BusinessLogic) {
//        self.interactor = interactor
//    }
    
    @Published var cryptos: [Crypto] = []

    @Published var errorMessage = ""

    @Published var hasError = false
    
    func getCryptos() async {
        errorMessage = ""
        
        await Service.shared.request(MultiTarget(CryptoRequest())) { result in
            switch result {
            case let .success(response):
            do {
                let responseData = String(data: response.data, encoding: .utf32)
                print("JSON String for \(String(reflecting: CryptoRequest.self)) \(responseData ?? "")")
                let cryptos = try CryptoRequest.decodeResult(from: response)
                self.cryptos = cryptos.data
            } catch {
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }

            case let .failure(error):
                self.errorMessage = error.localizedDescription
                self.hasError = true
            }
        }
    }
}

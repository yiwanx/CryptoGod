//
//  Crypto.swift
//  CryptoGodBase
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation

public struct Crypto: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let symbol: String
    public let totalSupply: Decimal?
    public let maxSupply: Decimal?
    public let quote: Quote?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case quote = "quote"
    }
}

public struct CryptoParent: Codable {
    public let data: [Crypto]
}

public struct Quote: Codable {
    public let USD: InstrumentPrice?
    public let BTC: InstrumentPrice?
}

public struct InstrumentPrice: Codable {
    public let price: Decimal?
    public let marketCap: Decimal?
    public let volumeChangeDay: Decimal?
    public let percentChangeHour: Decimal?
    public let percentChangeDay: Decimal?

    enum CodingKeys: String, CodingKey {
        case price = "price"
        case marketCap = "market_cap"
        case volumeChangeDay = "volume_change_24h"
        case percentChangeHour = "percent_change_1h"
        case percentChangeDay = "percent_change_24h"
    }
}

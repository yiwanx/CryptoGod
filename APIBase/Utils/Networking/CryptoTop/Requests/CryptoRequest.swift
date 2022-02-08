//
//  Crypto.swift
//  CryptoGodBase
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation
import Moya

public struct CryptoRequest {
    public init() {}
}

extension CryptoRequest: Request {

    public typealias Result = CryptoParent

    public var path: String { "cryptocurrency/listings/latest" }

    public var method: Moya.Method { .get }

    public var parameters: [String : Any]? {
        ["start": 1, "limit": 50, "convert": "USD"]
    }

}

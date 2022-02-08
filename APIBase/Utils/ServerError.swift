//
//  ServerError.swift
//  CryptoGodBase
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation

public struct ServerError: Error, Equatable {

    public let status: HTTPStatusCode

    public init(status: HTTPStatusCode) {
        self.status = status
    }
}

extension ServerError: Decodable {

    private enum CodingKeys: String, CodingKey {
        case status = "Error"
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let statusCode = Int(try container.decode(String.self, forKey: .status)) {
            status = HTTPStatusCode(rawValue: statusCode)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .status,
                                                   in: container,
                                                   debugDescription: "Expected an HTTP status code")
        }
    }
}

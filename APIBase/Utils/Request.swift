//
//  Request.swift
//  CryptoGodBase
//
//  Created by Ivan Petukhov on 25.12.2021.
//

import Foundation
import Moya

public protocol AnyRequest: TargetType {

    var parameters: [String : Any]? { get }

    var parameterEncoding: ParameterEncoding { get }

}

public extension AnyRequest {

    var headers: [String : String]? {
        ["X-CMC_PRO_API_KEY": Secret.API_KEY]
    }

    var baseURL: URL {
        Environment.baseURL
    }

    var parameterEncoding: ParameterEncoding {

        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    var task: Task {
        parameters.map { .requestParameters(parameters: $0, encoding: parameterEncoding) } ?? .requestPlain
    }

    var prefersCaching: Bool { false }

    var validationType: ValidationType { .successCodes }
}

public protocol Request: AnyRequest {

    associatedtype Result

    static func decodeResult(from response: Moya.Response) throws -> Result
}
//
extension Request {

    public static var responseTopLevelKey: String? { nil }
}

extension Request where Result: Decodable {

    public static func decodeResult(from response: Moya.Response) throws -> Result {
        if let json = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers),
           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            print(String(decoding: jsonData, as: UTF8.self))
        } else {
            print("json data malformed")
        }
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Result.self, from: response.data)
    }
}


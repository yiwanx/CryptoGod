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

    /// The top-level key of the JSON response. Defaults to `nil`, which means that
    /// we first try deserializing the whole JSON and if that fails,
    /// we use the result type name as the top-level key.
    static var responseTopLevelKey: String? { get }
}
//
extension Request {
//
//    internal static func getError(from response: Moya.Response) throws -> ServerError {
//
//        do {
//            return try Decoding.decode(ServerError.self,
//                                       topLevelKey: "Error",
//                                       from: response.data)
//        } catch {
//
//            let statusCode = HTTPStatusCode(rawValue: response.statusCode)
//
//            if statusCode.category != .success {
//                let message = NSLocalizedString("Произошла непредвиденная ошибка. Повторите попытку позже",
//                                                comment: "Сообщение когда сервер лежит")
//                return ServerError(status: statusCode,
//                                   code: nil,
//                                   message: message)
//            } else {
//                throw error
//            }
//        }
//    }

    public static var responseTopLevelKey: String? { nil }
}
//
extension Request where Result: Decodable {

    public static func decodeResult(from response: Moya.Response) throws -> Result {
        print("JSON String for \(String(reflecting: CryptoRequest.self)) \(String(data: response.data, encoding: .utf8))")
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(Result.self, from: response.data)
    }
}
//extension Request where Result == Void {
//
//    public static func decodeResult(from response: Moya.Response) throws -> Result {
//
//        if response.statusCode == successStatusCode { return }
//
//        throw try getError(from: response)
//    }
//}
//
//extension Request where Result == Data {
//
//    public static func decodeResult(from response: Moya.Response) throws -> Result {
//
//        if response.statusCode == successStatusCode {
//            return response.data
//        } else {
//            throw try getError(from: response)
//        }
//    }
//}
//
//extension Request where Result == UIImage {
//
//    public static func decodeResult(from response: Moya.Response) throws -> Result {
//
//        if response.statusCode == successStatusCode, let image = UIImage(data: response.data) {
//            return image
//        } else {
//            throw try getError(from: response)
//        }
//    }
//}

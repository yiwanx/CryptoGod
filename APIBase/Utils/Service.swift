//
//  Service.swift
//  CryptoGodBase
//
//  Created by Ivan Petukhov on 25.12.2021.
//
import Foundation
import Moya
import CombineMoya

public class Service {
    public static let shared = Service()
    
    public let provider: MoyaProvider<MultiTarget>

    private var cancellable: Cancellable?

    private init() {
        provider = MoyaProvider<MultiTarget>()
    }

    public func request(_ target: MultiTarget, completion: @escaping Completion) {
        cancellable?.cancel()
        cancellable = provider.request(target, completion: completion)
    }

}


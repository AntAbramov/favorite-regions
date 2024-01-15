//
//  RequestBuilderImpl.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Implementation

final class RequestBuilderImpl: RequestBuilder {
    func build(with request: any NetworkRequest) throws -> URLRequest {
        let url = try URLCreator.createURL(from: request.url)
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: request.cachePolicy,
            timeoutInterval: request.timeoutInterval
        )
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        return urlRequest
    }
}

//
//  NetworkServiceImpl.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Constant

private enum Constant {
    // swiftlint:disable:next no_magic_numbers
    static let successStatusCodeRange = 200..<300
}

// MARK: - Implementation

final class NetworkServiceImpl: NetworkService {
    // MARK: Dependency
    private let session: URLSession
    private let requestBuilder: RequestBuilder
    
    // MARK: init
    init(
        session: URLSession = .init(configuration: .cacheIgnoreConfig),
        requestBuilder: RequestBuilder = RequestBuilderImpl()
    ) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
}

// MARK: - Interface

extension NetworkServiceImpl {
    func fetchBrands() async throws -> Brands {
        let brandsNetworkRequest = BrandsNetworkRequest()
        do {
            return try await send(request: brandsNetworkRequest)
        } catch {
            throw error
        }
    }
    
    func downloadData(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await session.data(from: url)
            try verificateResponse(response)
            return data
        } catch {
            throw error
        }
    }
    
    func send<Request: NetworkRequest>(
        request: Request
    ) async throws -> Request.Response {
        do {
            let urlRequest = try requestBuilder.build(with: request)
            let (data, response) = try await session.data(for: urlRequest)
            try verificateResponse(response)
            return try decode(request: request, data: data)
        } catch {
            throw error
        }
    }
}

// MARK: - Private Methods

private extension NetworkServiceImpl {
    func verificateResponse(
        _ response: URLResponse
    ) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard Constant.successStatusCodeRange ~= httpResponse.statusCode else {
            throw NetworkError.invalidResponseStatusCode(httpResponse.statusCode)
        }
    }
        
    func decode<Request: NetworkRequest>(
        request: Request,
        data: Data
    ) throws -> Request.Response {
        let decoder = request.decoder
        do {
            return try decoder.decode(Request.Response.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

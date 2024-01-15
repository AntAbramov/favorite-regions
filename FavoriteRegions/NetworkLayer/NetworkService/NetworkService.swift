//
//  NetworkService.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

protocol BrandsFetcher {
    func fetchBrands() async throws -> Brands
}

protocol DataLoader {
    func downloadData(from: URL) async throws -> Data
}

protocol GenericNetwork {
    func send<Request: NetworkRequest>(
        request: Request
    ) async throws -> Request.Response
}

typealias NetworkService = DataLoader & BrandsFetcher & GenericNetwork

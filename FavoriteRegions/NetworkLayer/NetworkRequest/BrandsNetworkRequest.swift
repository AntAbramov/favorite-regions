//
//  BrandsNetworkRequest.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

final class BrandsNetworkRequest: NetworkRequest {
    typealias Response = Brands
    
    var decoder: JSONDecoder = .init()
    var httpMethod: HttpMethod = .GET
    var url: String = APIEndpoint.getBrands.url
    var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    var timeoutInterval: TimeInterval = 15
    var headers: [String: String]?
}

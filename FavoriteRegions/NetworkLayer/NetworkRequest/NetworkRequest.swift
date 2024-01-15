//
//  NetworkRequest.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

protocol NetworkRequest {
    associatedtype Response: Decodable
    
    var decoder: JSONDecoder { get }
    var httpMethod: HttpMethod { get }
    var url: String { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    var timeoutInterval: TimeInterval { get }
    var headers: [String: String]? { get }
}

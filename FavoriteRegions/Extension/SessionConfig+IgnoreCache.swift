//
//  SessionConfig+IgnoreCache.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

extension URLSessionConfiguration {
    static let cacheIgnoreConfig: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringCacheData
        return config
    }()
}

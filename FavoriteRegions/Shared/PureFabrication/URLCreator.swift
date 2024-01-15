//
//  URLCreator.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

enum URLCreator {
    static func createURL(from string: String) throws -> URL {
        guard let url = URL(string: string) else {
            throw NetworkError.cantBuildURL
        }
        return url
    }
}

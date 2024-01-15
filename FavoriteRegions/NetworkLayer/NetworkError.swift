//
//  NetworkError.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case decodingFailed
    case cantBuildURL
    case invalidResponse
    case invalidResponseStatusCode(Int)
    
    var localizedDescription: String {
        switch self {
        case .decodingFailed:
            "Can not decode response"
        case .cantBuildURL:
            "Can not build URL from String"
        case .invalidResponse:
            "Invalid response"
        case .invalidResponseStatusCode(let code):
            "Invalid response status code: \(code) "
        }
    }
}

//
//  APIEndpoint.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

enum APIEndpoint {
    case getBrands

    private enum Host: String {
        case wildberries = "https://vmeste.wildberries.ru"
    }
    
    private enum Path: String {
        case brands = "/api/guide-service/v1/getBrands"
    }
    
    var url: String {
        switch self {
        case .getBrands:
            return Host.wildberries.rawValue + Path.brands.rawValue
        }
    }
}

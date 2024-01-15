//
//  Router.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Route

enum Route: Hashable {
    case regionDetail(RegionDTO)
}

// MARK: - Implementation

final class Router: ObservableObject {
    static let shared = Router()
    
    // MARK: @Published
    @Published var path: [Route] = []
}

// MARK: - Interface

extension Router {
    func showRegionDetail(_ dto: RegionDTO) {
        path.append(.regionDetail(dto))
    }
    
    func popView() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}

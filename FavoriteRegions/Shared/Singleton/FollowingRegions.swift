//
//  FollowingRegions.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Implementation

final class FollowingRegions: ObservableObject {
    static let shared = FollowingRegions()
    
    // MARK: @Published
    @Published var valueChanged = true
    
    // MARK: Data
    private var dict = [String: Bool]() {
        didSet {
            valueChanged.toggle()
        }
    }
}

// MARK: - Interface

extension FollowingRegions {
    func fetch(for title: String) -> Bool {
        let key = title.lowercased()
        return dict[key] ?? false
    }
    
    func set(value: Bool, for title: String) {
        let key = title.lowercased()
        dict[key] = value
    }
}

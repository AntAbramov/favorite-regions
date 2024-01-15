//
//  RegionTitleViewModel.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

// MARK: - Implementation

final class RegionTitleViewModel: ObservableObject {
    // MARK: Property
    let title: String
    
    // MARK: init
    init(title: String) {
        self.title = title
    }
}

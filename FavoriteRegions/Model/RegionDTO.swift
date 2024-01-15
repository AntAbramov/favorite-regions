//
//  RegionDTO.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

struct RegionDTO: Identifiable, Equatable, Hashable {
    let brandId: String
    let title: String
    let thumbUrls: [URL]
    let viewsCount: Int
    var id: UUID = .init()
}

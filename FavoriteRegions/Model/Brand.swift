//
//  Brand.swift
//  FavoriteRegions
//
//  Created by Anton Abramov on 14.01.2024.
//

import Foundation

struct Brands: Decodable {
    let brands: [Brand]
    
    func prepareDTO() -> [RegionDTO] {
        brands.map {
            RegionDTO(
                brandId: $0.brandId,
                title: $0.title,
                thumbUrls: $0.thumbUrls,
                viewsCount: $0.viewsCount
            )
        }
    }
}

struct Brand: Decodable {
    let brandId: String
    let title: String
    let thumbUrls: [URL]
    let tagIds: [String]
    let slug: String
    let type: String
    let viewsCount: Int
}

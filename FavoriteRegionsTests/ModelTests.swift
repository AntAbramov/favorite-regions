//
//  ModelTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

final class ModelTests: XCTestCase {
    private let mockBrands = Brands(brands: [
        Brand(
            brandId: "1",
            title: "Moscow",
            thumbUrls: [URL](),
            tagIds: ["1"],
            slug: "1",
            type: "Type",
            viewsCount: 100
        )
    ])
    
    private let resultDto = RegionDTO(
        brandId: "1",
        title: "Moscow",
        thumbUrls: [URL](),
        viewsCount: 100
    )
    
    func testDTO() {
        let dto = mockBrands.prepareDTO()[0]
        XCTAssertEqual(dto.title, resultDto.title)
        XCTAssertTrue(dto.thumbUrls.isEmpty)
        XCTAssertEqual(dto.viewsCount, 100)
        XCTAssertEqual(dto.brandId, "1")
    }
}

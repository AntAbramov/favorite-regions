//
//  RouterTests.swift
//  FavoriteRegionsTests
//
//  Created by Anton Abramov on 15.01.2024.
//

import XCTest
@testable import FavoriteRegions

final class RouterTests: XCTestCase {
    // swiftlint:disable:next implicitly_unwrapped_optional
    private var router: Router!
    
    private let dto = RegionDTO(
        brandId: "1",
        title: "Moscow",
        thumbUrls: [URL](),
        viewsCount: 100
    )
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        router = Router()
    }
    
    override func tearDownWithError() throws {
        router = nil
        try super.tearDownWithError()
    }
    
    func testShowRegionDetail() {
        router.showRegionDetail(dto)
        XCTAssertEqual(router.path.count, 1, "Failed to add Route to path")
        XCTAssertEqual(router.path[0], .regionDetail(dto), "Invalid Route in path")
    }
    
    func testPopView() {
        router.showRegionDetail(dto)
        router.popView()
        XCTAssertEqual(router.path.count, 0, "Failed to pop Route from path")
    }
    
    func testPopToRoot() {
        router.showRegionDetail(dto)
        router.showRegionDetail(dto)
        router.popToRoot()
        XCTAssertEqual(router.path.count, 0, "Failed to remove all Route from path")
    }
}
